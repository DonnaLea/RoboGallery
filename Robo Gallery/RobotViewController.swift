//
//  RobotViewController.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

/// View controller to display the Robot in detail with an image and a label.
final class RobotViewController: UIViewController {

  // MARK: - Properties

  /// Robot to be displayed.
  private let robot: Robot

  /// Easy reference to keep the relevant `robot` image data.
  private let imageData: Data

  /// Image view of the robot.
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit

    return imageView
  }()

  /// Label for the robot text.
  private lazy var label: UILabel = {
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

  /**
   Returns a newly initialized RobotViewController with the robot displaying the image for the specified index.

   - Parameter robot: The robot to display.
   - Parameter index: The specific image to display of the robot.

   - Returns: A newly initialized RobotViewController.
   */
  init(robot: Robot, index: Int) {
    self.robot = robot
    imageData = robot.imageData(index: index)
    super.init(nibName: nil, bundle: nil)
    title = robot.text
  }

  /// Storyboards not supported.
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

    if imageData.count > 0 {
      imageView.image = UIImage(data: imageData)
    }
  }
}
