//
//  Constants.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 21/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import Foundation

struct RealmConstants {

  // **** ROS On-Premises Users
  // **** Replace the AUTH_URL and REALM_URL strings with the fully qualified versions of
  // **** address of your ROS server, e.g.: "http://127.0.0.1:9080" and "realm://127.0.0.1:9080"

  static let MY_INSTANCE_ADDRESS = "robo-gallery.us1.cloud.realm.io"

  static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!
  static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/RoboGallery")!
}
