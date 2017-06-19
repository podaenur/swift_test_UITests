//
//  swift_test_UITestsUITests.swift
//  swift_test_UITestsUITests
//
//  Created by Evgeniy Akhmerov on 20/01/17.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import XCTest

class swift_test_UITestsUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        XCUIDevice.shared().orientation = .landscapeLeft
        continueAfterFailure = false
        application.launch()
    }
    
    func testButtonEnabling() {
        let buttonQuery = application.descendants(matching: .button)
        let wrongButton = buttonQuery.element(matching: .button, identifier: "wrong_checkItButton")
        let correctButton = buttonQuery.element(matching: .button, identifier: "checkItButton")
        
        XCTAssertFalse(wrongButton.exists)
        XCTAssertTrue(correctButton.exists)
        XCTAssertFalse(correctButton.isEnabled)
        
        let textFieldQuery = application.descendants(matching: .textField)
        let wrongTextField = textFieldQuery.element(matching: .textField, identifier: "wrong_isItIdentifier")
        let correctTextField = textFieldQuery.element(matching: .textField, identifier: "isItIdentifier")
        XCTAssertFalse(wrongTextField.exists)
        XCTAssertTrue(correctTextField.exists)
        
        correctTextField.tap()
        
        correctTextField.typeText("pobla")
        XCTAssertFalse(correctButton.isEnabled)

        correctTextField.typeText("123")
        XCTAssertTrue(correctButton.isEnabled)
    }
    
    func testTextPassing() {
        let testingText = "1029384756"
        let textField = application.textFields["isItIdentifier"]
        textField.tap()
        textField.typeText(testingText)
        
        XCTAssertEqual((textField.value as? String), testingText)
        
        XCUIDevice.shared().orientation = .portrait
        
        application.buttons["checkItButton"].tap()
        
        let result = application.staticTexts["resultLabel"].label
        XCTAssertEqual(result, testingText)
    }
    
    func testReturningBack() {
        let testingText = "1"
//        let textField = application.textFields["isItIdentifier"]
        let textField = application.textFields["isItIdentifier_______"]
        textField.tap()
        textField.typeText(testingText)
        
        XCUIDevice.shared().orientation = .portrait
        
        application.buttons["checkItButton"].tap()
        
        let naviBar = application.navigationBars["swift_test_UITests.PreviewView"]
        XCTAssertTrue(naviBar.exists)
        let backButton = naviBar.buttons["Back"]
        XCTAssertTrue(backButton.exists)
        
        backButton.tap()
        
        let checkButton = application.buttons["checkItButton"]
        XCTAssertTrue(checkButton.exists)
    }
}
