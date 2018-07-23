//
//  Robot.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

import RealmSwift

/// Robot is made up of both a UIString and an array of Data objects representing a UIImage. The `text` string is the text used to fetch the robot and the `images` are the resulting images from the fetch based on each set. Set 1 image is different to set 2 and set 3. This structure can handle many sets, though the robohash api has only 4 different sets.
final class Robot: Object {

  // MARK: - Properties

  /// Text used to fetch the Robot.
  @objc dynamic var text = ""

  /// The resulting robot image from fetching with `text`.
  private let images = List<RobotImage>()

  /// The timestamp when the robot was requested.
  @objc dynamic var timestamp = Date()

  // MARK: - Custom

  /**
   Getter for the robot image data for the specified index.

   - Parameter index: Zero based, the index represents the image set to get.

   - Returns: A Data object that can be used to create a UIImage.
   */
  func imageData(index: Int) -> Data {
    let robotImage = images.filter { $0.key ==  index }.first ?? RobotImage()

    return robotImage.data
  }

  /**
   Setter for the robot image data for the specified index.

   - Parameter index: Zero based, the index represents the image set to get.

   - Parameter imageData: Data object to store for the given index.
   */
  func setImageData(index: Int, imageData: Data) {
    let storedRobotImage = images.filter { $0.key == index }.first
    if let storedRobotImage = storedRobotImage {
      storedRobotImage.data = imageData
    } else {
      let robotImage = RobotImage()
      robotImage.key = index
      robotImage.data = imageData
      images.append(robotImage)
    }
  }
}

/// RobotImage is the workaround for realm not handling a dictionary object. The `key` keeps track of which set the `data` is for.
final class RobotImage: Object {
  /// Represents the set the `data` is for.
  @objc dynamic var key = 0

  /// The image data of a robot. Can be used to create a UIImage.
  @objc dynamic var data = Data()
}
