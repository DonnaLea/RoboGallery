//
//  RobotCollectionViewCell.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

final class RobotCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill

    return imageView
  }()

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

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not supported")
  }

  // MARK: - Custom

  func setImage(image: UIImage?) {
    imageView.image = image
    if image == nil {
      activityIndicatorView.startAnimating()
    } else {
      activityIndicatorView.stopAnimating()
    }
  }
}
