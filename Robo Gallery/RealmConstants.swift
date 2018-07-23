//
//  Constants.swift
//  Robo Gallery
//
//  Created by Donna McCulloch on 21/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import Foundation

/// Holds constants relevant to realm.
struct RealmConstants {

  /// The address for my realm instance.
  static let MY_INSTANCE_ADDRESS = "robo-gallery.us1.cloud.realm.io"

  /// The authentication URL based on the instance address.
  static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!

  /// The realm URL based on the instance address.
  static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/RoboGallery")!
}
