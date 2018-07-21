//
//  RobotViewController.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

/// View controller to display the Robot in detail with an image and a label.
class RobotViewController: UIViewController {

  // MARK: - Properties

  /// Robot to be displayed.
  let robot: Robot

  /// Image view of the robot.
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit

    return imageView
  }()

  // Label of the robot text.
  lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = robot.text
    label.textAlignment = .center
    label.numberOfLines = 0
    label.backgroundColor = .white
    label.alpha = 0.8

    return label
  }()

  // MARK: - Init
  init(robot: Robot) {
    self.robot = robot
    super.init(nibName: nil, bundle: nil)
    title = robot.text
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not supported")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    // Image view.
    view.addSubview(imageView)
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imageView.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
    view.safeAreaLayoutGuide.bottomAnchor.constraintEqualToSystemSpacingBelow(imageView.bottomAnchor, multiplier: 1).isActive = true

    // Label.
    view.addSubview(label)
    label.leadingAnchor.constraintEqualToSystemSpacingAfter(view.leadingAnchor, multiplier: 1).isActive = true
    view.trailingAnchor.constraintEqualToSystemSpacingAfter(label.trailingAnchor, multiplier: 1).isActive = true
    view.safeAreaLayoutGuide.bottomAnchor.constraintEqualToSystemSpacingBelow(label.bottomAnchor, multiplier: 1).isActive = true
    label.topAnchor.constraintEqualToSystemSpacingBelow(imageView.bottomAnchor, multiplier: 1).isActive = true

    imageView.image = robot.image
  }


}
