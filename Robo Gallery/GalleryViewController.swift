//
//  GalleryViewController.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 18/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage
import RealmSwift

final class GalleryViewController: UICollectionViewController {

  // MARK: - Properties

  /// Constants relevant to just this class.
  private struct Constants {
    /// Spacing between cells, vertical and horizontal.
    static let cellSpacing = CGFloat(2.0)

    /// Number of items to display in a row.
    static let itemsPerRow: CGFloat = 4

    /// URL to the robo hash api.
    static let robotURL: String = "https://robohash.org/"
  }

  /// Search controller for requesting a robot.
  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    // Don't hide the navigation bar because the search bar is in it.
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.dimsBackgroundDuringPresentation = false

    return searchController
  }()

  /// Segmented controller for switching between sets of robots.
  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Set 1", "Set 2", "Set 3"])
    segmentedControl.selectedSegmentIndex = 0

    return segmentedControl
  }()

  /// Getter for currently selected index of sets.
  private var currentIndex: Int {
    return segmentedControl.selectedSegmentIndex
  }

  /// Realm to store objects in the cloud and persist locally.
  private let realm: Realm

  /// Robots that have been stored in `realm`.
  private let robots: Results<Robot>

  /// Notification token to track changes in `realm`.
  private var notificationToken: NotificationToken?

  // MARK: - Init

  /// Defaults to using the `UICollectionViewFlowLayout`.
  convenience init() {
    let layout = UICollectionViewFlowLayout()
    self.init(collectionViewLayout: layout)
  }

  override init(collectionViewLayout layout: UICollectionViewLayout) {

    let syncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: RealmConstants.REALM_URL)
    self.realm = try! Realm(configuration: Realm.Configuration(syncConfiguration: syncConfig, objectTypes:[Robot.self, RobotImage.self]))
    self.robots = realm.objects(Robot.self).sorted(byKeyPath: "timestamp", ascending: false)

    super.init(collectionViewLayout: layout)

    segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
    searchController.searchBar.delegate = self
    addRealmNotificationHandler()
    updateRobotsIfNeeded()
  }

  /// Storyboards not supported.
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not supported")
  }

  // MARK: - Deinit

  deinit {
    notificationToken?.invalidate()
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Collection View.
    collectionView?.backgroundColor = .white
    collectionView?.register(ImageActivityCollectionViewCell.self, forCellWithReuseIdentifier: ImageActivityCollectionViewCell.reuseIdentifier())

    // Place the search bar in the navigation item's title view.
    navigationItem.titleView = searchController.searchBar

    addSegmentedControl()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setToolbarHidden(false, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setToolbarHidden(true, animated: animated)
  }

  // MARK: - Actions

  /**
   Action for `segmentedControl` value being changed by tapping a different index. This reloads the collection view to display the new set of images for each robot. If the robots haven't already got an image
   stored for the new index then the images will be requested.

   - Parameter sender: The segmented control that was changed.
   */
  @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
    // Using reloadSections instead of reloadData due to a bug where performBatchUpdates after reloadData does not finish reloading the other cells.
    // Details can be seen at this open radar: http://www.openradar.me/31748196 and github project made for the openradar https://github.com/lionheart/openradar-mirror/issues/17286
    collectionView?.reloadSections(IndexSet(integer: 0))
    updateRobotsIfNeeded()
  }

  // MARK: - Custom

  /**
   Create a robot and request an image with the given `text` and `set` where `set` is not zero based, starting at 1.

   - Parameter text: The text used to fetch the robot image.
   - Parameter set: The specific robot set to fetch the robot image of.
   */
  private func requestRobot(text: String, set: Int) {
    let robot = Robot()
    robot.text = text
    try? realm.write {
      realm.add(robot)
    }

    requestImageFor(robot: robot, set: set)
  }

  /**
   Request a robot image for the given `robot` and `set` where `set` is not zero based, starting at 1.

   - Parameter robot: The robot text will be used to fetch the robot image.
   - Parameter set: The specific robot set to fetch the robot image of.
   */
  private func requestImageFor(robot: Robot, set: Int) {
    if let urlSafeText = robot.text.addingPercentEncoding(withAllowedCharacters: .init()) {
      let urlString = Constants.robotURL.appending(urlSafeText).appending("?set=set\(set)")

      Alamofire.request(urlString).responseImage { response in
        if let image = response.result.value, let imageData = UIImagePNGRepresentation(image), imageData.count > 0 {
          // Save image data to robot.
          try? self.realm.write {
            robot.setImageData(index: set-1, imageData: imageData)
          }
        }
      }
    } else {
      searchController.isActive = false
      searchController.searchBar.text = nil
    }
  }

  /// Add the segmented control to the toolbar in the `navigationController`.
  private func addSegmentedControl() {
    let segmentControlToolbarItem = UIBarButtonItem(customView: segmentedControl)
    let toolbarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let toolbarItems = [toolbarSpace, segmentControlToolbarItem, toolbarSpace]
    setToolbarItems(toolbarItems, animated: false)
  }

  /// Loop through each robot and request an image for the current set if one isn't already stored.
  private func updateRobotsIfNeeded() {
    for robot in robots {
      if robot.imageData(index: currentIndex).count == 0 {
        requestImageFor(robot: robot, set: currentIndex+1)
      }
    }
  }

  /// Add a notification handler to update the `collectionView` when data changes in `realm`.
  private func addRealmNotificationHandler() {
    notificationToken = robots.observe { changes in
      guard let collectionView = self.collectionView else { return }
      switch changes {
      case .initial:
        // Results are now populated and can be accessed without blocking the UI.
        collectionView.reloadData()
      case .update(_, let deletions, let insertions, let modifications):
        // Query results have changed, so apply them to the CollectionView.
        collectionView.performBatchUpdates({
          collectionView.insertItems(at: insertions.map({IndexPath(row: $0, section: 0)}))
          collectionView.deleteItems(at: deletions.map({IndexPath(row: $0, section: 0)}))
          collectionView.reloadItems(at: modifications.map({IndexPath(row: $0, section: 0)}))
        }, completion: nil)
      case .error(let error):
        // An error occurred while opening the Realm file on the background worker thread
        fatalError("\(error)")
      }
    }
  }

}

// MARK: - UICollectionViewDataSource

extension GalleryViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return robots.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageActivityCollectionViewCell.reuseIdentifier(), for: indexPath) as! ImageActivityCollectionViewCell
    let robot = robots[indexPath.row]

    let imageData = robot.imageData(index: currentIndex)
    if imageData.count > 0 {
      cell.setImage(image: UIImage(data: imageData))
    } else {
      cell.setImage(image: nil)
    }

    return cell
  }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = Constants.cellSpacing * (Constants.itemsPerRow - 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / Constants.itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.cellSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.cellSpacing
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let robot = robots[indexPath.row]
    navigationController?.pushViewController(RobotViewController(robot: robot, index: currentIndex), animated: true)
  }
}


// MARK: - UISearchBarDelegate

extension GalleryViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      requestRobot(text: text, set: currentIndex+1)
    }
  }
}

