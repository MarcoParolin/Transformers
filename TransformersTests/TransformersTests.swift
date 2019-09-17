//
//  TransformersTests.swift
//  TransformersTests
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import XCTest
import ServiceManager
@testable import Transformers

class TransformersTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
    }

    func testTie() {
        let transformers = TransformersDataSource.tieCase
        Battle.start(transformers) { result in
            guard let winner = result.winner else {
                XCTFail("Winner should be autobots, not nil")
                return
            }
            XCTAssertEqual(winner, .autobots, "Battle should have ended in a win for autobots")
            XCTAssertEqual(result.matchResults.first?.reason, .tie, "Match should have ended in a tie")
        }
    }
    
    func testFlee() {
        let transformers = TransformersDataSource.fleeCase
        Battle.start(transformers) { result in
            guard let winner = result.winner else {
                XCTFail("Winner should be autobots, not nil")
                return
            }
            XCTAssertEqual(winner, .autobots, "Battle should have ended in a win for autobots")
            XCTAssertEqual(result.matchResults.first?.reason, .fleed, "Match should have ended in a flee")
        }
    }
    
    func testOutskill() {
        let transformers = TransformersDataSource.outskillCase
        Battle.start(transformers) { result in
            guard let winner = result.winner else {
                XCTFail("Winner should be autobots, not nil")
                return
            }
            XCTAssertEqual(winner, .autobots, "Battle should have ended in a win for autobots")
            XCTAssertEqual(result.matchResults.first?.reason, .outskilled, "Match should have ended in an Outskill")
        }
    }
    
    func testBoss() {
        let transformers = TransformersDataSource.bossCase
        Battle.start(transformers) { result in
            guard let winner = result.winner else {
                XCTFail("Winner should be autobots, not nil")
                return
            }
            XCTAssertEqual(winner, .decepticons, "Battle should have ended in a win for autobots")
            XCTAssertEqual(result.matchResults.first?.reason, .instaWin, "Match should have ended in a instawin")
        }
    }
    
    func testDestruction() {
        let transformers = TransformersDataSource.destructionCase
        Battle.start(transformers) { result in
            XCTAssert(result.winner == nil, "There should be no winner")
        }
    }

}
