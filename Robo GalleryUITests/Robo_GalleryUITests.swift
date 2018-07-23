//
//  Robo_GalleryUITests.swift
//  Robo GalleryUITests
//
//  Created by Donna McCulloch on 18/7/18.
//  Copyright © 2018 Donna McCulloch. All rights reserved.
//

import XCTest

class Robo_GalleryUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestingRobotA() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

      let app = XCUIApplication()
      XCTAssertTrue(app.navigationBars["Robo_Gallery.GalleryView"].searchFields["Search"].isEnabled)
      app.navigationBars["Robo_Gallery.GalleryView"].searchFields["Search"].tap()

      let aKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
      aKey.tap()
      app/*@START_MENU_TOKEN@*/.keyboards.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
      app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
      app.otherElements.containing(.navigationBar, identifier:"A").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
    }

  func testSegmentedControl() {

    let toolbar = XCUIApplication().toolbars["Toolbar"]
    XCTAssertTrue(toolbar.isEnabled)
    XCTAssertEqual(toolbar.buttons.count, 3)
    toolbar/*@START_MENU_TOKEN@*/.buttons["Set 2"]/*[[".segmentedControls.buttons[\"Set 2\"]",".buttons[\"Set 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    toolbar/*@START_MENU_TOKEN@*/.buttons["Set 3"]/*[[".segmentedControls.buttons[\"Set 3\"]",".buttons[\"Set 3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

  }
    
}
