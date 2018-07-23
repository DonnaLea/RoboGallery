//
//  ImageActivityCollectionViewCell.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

/// Collection view cell to display an image or activity indicator.
final class ImageActivityCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  /// The image view to display the image.
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill

    return imageView
  }()

  /// Activity indicator to show that no image is currently available, but one is being loaded.
  private let activityIndicatorView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    view.hidesWhenStopped = true
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(imageView)
    imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true

    addSubview(activityIndicatorView)
    activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
  }

  /// Storyboards not supported.
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not supported")
  }

  // MARK: - Custom

  /**
   Sets the image to be displayed. If image is nil, the activity indicator will display, otherwise the image is displayed.

   - Parameter image: The image to be displayed.
   */
  func setImage(image: UIImage?) {
    imageView.image = image
    if image == nil {
      activityIndicatorView.startAnimating()
    } else {
      activityIndicatorView.stopAnimating()
    }
  }
}
