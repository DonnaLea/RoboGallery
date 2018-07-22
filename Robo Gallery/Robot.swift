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
class Robot: Object {

  /// Text used to fetch the Robot.
  @objc dynamic var text: String = ""

  /// The resulting robot image from fetching with `text`.
  @objc dynamic var imageData: Data?

  /// The timestamp when the robot was requested.
  @objc dynamic var timestamp: Date = Date()

}
