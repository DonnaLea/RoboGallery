//
//  Robo_GalleryTests.swift
//  Robo GalleryTests
//
//  Created by Donna McCulloch on 18/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import XCTest
@testable import Robo_Gallery

class Robo_GalleryTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  /// Test a new robot is empty of data.
  func testNewRobot() {
    let robot = Robot()
    XCTAssertTrue(robot.text.isEmpty)
    XCTAssertEqual(robot.imageData(index: 0).count, 0)
    XCTAssertEqual(robot.imageData(index: 1).count, 0)
    XCTAssertEqual(robot.imageData(index: 2).count, 0)
  }

  /// Test the custom getter and setter for robot image data works and doesn't require starting at index 0.
  func testImageData() {
    let robot = Robot()
    let testBundle = Bundle(for: type(of: self))
    let data = UIImagePNGRepresentation(UIImage(named: "cool", in: testBundle, compatibleWith: nil)!)!
    let index = 2
    robot.setImageData(index: index, imageData: data)
    XCTAssertEqual(robot.imageData(index: index), data)
  }
    
}
