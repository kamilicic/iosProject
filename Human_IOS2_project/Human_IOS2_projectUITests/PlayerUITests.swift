//
//  PlayerUITests.swift
//  Human_IOS2_projectUITests
//
//  Created by Kryštof Bůšek on 28.01.2024.
//

import XCTest
@testable import Human_IOS2_project
import SpriteKit
import GameplayKit

final class PlayerMovementTest: XCTestCase {
    var app: XCUIApplication!
    
    var attackButton: XCUIElement {
        app.otherElements["attackButton"]
    }
    var interactButton: XCUIElement {
        app.otherElements["interactButton"]
    }
    var openInventoryButton: XCUIElement {
        app.otherElements["openInventoryButton"]
    }
    
    var closeButton: XCUIElement {
        app.otherElements["closeButton"]
    }
    
    var placable: XCUIElement {
        app.otherElements["placable"]
    }
    
    var play: XCUIElement {
        app.buttons["play"]
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testButtonsExist() throws {
        // UI tests must launch the application that they test.
        XCTAssertTrue(play.waitForExistence(timeout: 5))
        play.tap()
        XCTAssertTrue(attackButton.waitForExistence(timeout: 20), "Button not found" )
        XCTAssertTrue(interactButton.waitForExistence(timeout: 5), "Button not found" )
        XCTAssertTrue(openInventoryButton.waitForExistence(timeout: 5), "Button not found" )
        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
        
    func testGoingToInventoryAndBack() throws {
        XCTAssertTrue(play.waitForExistence(timeout: 5))
        play.tap()
        
        XCTAssertTrue(openInventoryButton.waitForExistence(timeout: 20), "Button not found")
        openInventoryButton.tap()
        
        XCTAssertFalse(openInventoryButton.waitForExistence(timeout: 5), "Button found" )
        closeButton.tap()
        
        XCTAssertTrue(openInventoryButton.waitForExistence(timeout: 5), "Button not found" )
    }
    
    
    func testPlaceAndDestroyItem() throws{
        XCTAssertTrue(play.waitForExistence(timeout: 5))
        play.tap()
        
        XCTAssertTrue(openInventoryButton.waitForExistence(timeout: 20), "Button not found")
        openInventoryButton.tap()
        
        XCTAssertTrue(placable.waitForExistence(timeout: 5), "Button not found" )
        placable.tap()
        
        XCTAssertTrue(closeButton.waitForExistence(timeout: 5), "Button not found" )
        closeButton.tap()
        
        XCTAssertTrue(interactButton.waitForExistence(timeout: 5), "Button not found" )
        interactButton.tap()
        
        XCTAssertTrue(attackButton.waitForExistence(timeout: 15), "Button not found" )
        attackButton.tap()
        
        XCTAssertTrue(attackButton.waitForExistence(timeout: 10), "Button not found" )
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
