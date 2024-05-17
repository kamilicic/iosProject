//
//  PlayerUnitTests.swift
//  Human_IOS2_projectTests
//
//  Created by Kryštof Bůšek on 28.01.2024.
//

import XCTest
@testable import Human_IOS2_project
import SpriteKit

final class PlayerUnitTests: XCTestCase {
    var player = PlayerNode(xpos: 0, lRight: true)
    var healthStat = StatsNode(texture: SKTexture(imageNamed: ""), color: .clear)
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testInit() throws {
        XCTAssertEqual(player.storedItems[0], 1000)
        XCTAssertEqual(healthStat.rectangle.size.width, 150)
    }
    
    
    func testStoringItem() throws {
        player.storeItem(item: 8)
        player.storeItem(item: 8)
        player.storeItem(item: 8)
        XCTAssertEqual(player.storedItems[8], 103)
    }
    
    
    func testHPDown() throws {
        healthStat.statMinus(howMuch: 3)
        XCTAssertEqual(healthStat.rectangle.size.width, 105)
    }
    
    func testHPUp() throws {
        healthStat.rectangle.size.width = 105
        healthStat.statPlus(howMuch: 3)
        XCTAssertEqual(healthStat.rectangle.size.width, 150)
    }
    
    func testHPFull() throws {
        healthStat.statPlus(howMuch: 3)
        XCTAssertEqual(healthStat.rectangle.size.width, 150)
    }
    
    func testHPZero() throws {
        healthStat.statMinus(howMuch: 10)
        XCTAssertEqual(healthStat.rectangle.size.width, 0)
        
        healthStat.statMinus(howMuch: 5)
        XCTAssertEqual(healthStat.rectangle.size.width, 0)
    }
}
