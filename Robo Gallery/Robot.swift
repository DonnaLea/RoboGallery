//
//  Robot.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 19/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import UIKit

import RealmSwift

/// Robot is made up of both a UIString and a UIImage. The `text` string is the text used to fetch the robot and the `image` is the resulting image from the fetch.
final class Robot: Object {

  /// Text used to fetch the Robot.
  @objc dynamic var text = ""

  /// The resulting robot image from fetching with `text`.
  private let images = List<RobotImage>()

  /// The timestamp when the robot was requested.
  @objc dynamic var timestamp = Date()

  func imageData(index: Int) -> Data {
    let robotImage = images.filter { $0.key ==  index }.first ?? RobotImage()

    return robotImage.data
  }

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

final class RobotImage: Object {
  @objc dynamic var key = 0

  @objc dynamic var data = Data()
}
