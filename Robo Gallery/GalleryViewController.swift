//
//  GalleryViewController.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 18/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController {

  // MARK: - Properties
  fileprivate struct Constants {
    static let cellSpacing = CGFloat(2.0)
    static let itemsPerRow: CGFloat = 4
  }

  // Search field.
  let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    // Don't hide the navigation bar because the search bar is in it.
    searchController.hidesNavigationBarDuringPresentation = false

    return searchController
  }()

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
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier())

    // Place the search bar in the navigation item's title view.
    self.navigationItem.titleView = searchController.searchBar

  }

}

// MARK: - UICollectionViewDataSource
extension GalleryViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier(), for: indexPath)
    cell.backgroundColor = .red

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
}


// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("search: \(String(describing: searchBar.text))")
  }

}

