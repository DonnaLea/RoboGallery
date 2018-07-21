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
  var text: String = ""

  /// The resulting robot image from fetching with `text`.
  var image: UIImage?

}
