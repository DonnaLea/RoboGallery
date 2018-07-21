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

class GalleryViewController: UICollectionViewController {

  // MARK: - Properties
  fileprivate struct Constants {
    static let cellSpacing = CGFloat(2.0)
    static let itemsPerRow: CGFloat = 4
    static let robotURL: String = "https://robohash.org/"
  }

  // Search field.
  let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    // Don't hide the navigation bar because the search bar is in it.
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.dimsBackgroundDuringPresentation = false

    return searchController
  }()

  // Robots.
  var robots = [Robot]()

  // MARK: - Init
  convenience init() {
    let layout = UICollectionViewFlowLayout()
    self.init(collectionViewLayout: layout)
  }

  override init(collectionViewLayout layout: UICollectionViewLayout) {
    super.init(collectionViewLayout: layout)

    searchController.searchBar.delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not supported")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    // Collection View.
    collectionView?.backgroundColor = .white
    collectionView?.register(RobotCollectionViewCell.self, forCellWithReuseIdentifier: RobotCollectionViewCell.reuseIdentifier())

    // Place the search bar in the navigation item's title view.
    self.navigationItem.titleView = searchController.searchBar

  }

  // MARK: - Custom

  /// Request a robot image with the given `text`.
  private func requestRobot(text: String) {
    let robot = Robot()
    robot.text = text
    robots.append(robot)
    self.collectionView?.reloadData()
    let row = robots.count - 1
    if let urlSafeText = text.addingPercentEncoding(withAllowedCharacters: .init()) {
      let urlString = Constants.robotURL.appending(urlSafeText)

      Alamofire.request(urlString).responseImage { response in
        if let image = response.result.value {
          // Save image data to robot.
          robot.image = image
          self.collectionView?.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
      }
    } else {
      searchController.isActive = false
      searchController.searchBar.text = nil
    }
  }

}

// MARK: - UICollectionViewDataSource
extension GalleryViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return robots.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RobotCollectionViewCell.reuseIdentifier(), for: indexPath) as! RobotCollectionViewCell
    let robot = robots[indexPath.row]

    cell.setImage(image: robot.image)

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
    navigationController?.pushViewController(RobotViewController(robot: robot), animated: true)
  }
}


// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      requestRobot(text: text)
    }
  }
}

