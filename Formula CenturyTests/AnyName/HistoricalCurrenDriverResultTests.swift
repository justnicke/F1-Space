//
//  HistoricalCurrenDriverResultTests.swift
//  Formula CenturyTests
//
//  Created by Nikita Sukachev on 22.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import XCTest
@testable import Formula_Century

//class HistoricalCurrenDriverResultTests: XCTestCase {
//
//    var sut: HistoricalCurrentDriverResultConfigurable?
//    
//    override func setUpWithError() throws {
//        sut = HistoricalCurrenDriverResultStub()
//    }
//
//    override func tearDownWithError() throws {
//        sut = nil
//    }
//
//    // MARK: - Pole Position
//    
//    func testCheckExistPolePosition() {
//        sut?.getPolePosition("1")
//        XCTAssertEqual(sut?.poleCounter, 1)
//    }
//    
//    func testCheckNotExistPolePosition() {
//        sut?.getPolePosition("something")
//        XCTAssertNotEqual(sut?.poleCounter, 1)
//    }
//    
//    // MARK: - Fastest Lap
//    
//    func testCheckExistFastestLap() {
//        sut?.getFastestLap("1")
//        XCTAssertEqual(sut?.fastestLapCounter, 1)
//    }
//    
//    func testCheckNotExistFastestLap() {
//        sut?.getFastestLap("something")
//        XCTAssertNotEqual(sut?.fastestLapCounter, 1)
//    }
//    
//    // MARK: - Retire
//    
//    func testCheckExistRetire() {
//        sut?.getRetire("R")
//        XCTAssertEqual(sut?.retireCounter, 1)
//    }
//    
//    func testCheckNotExistRetire() {
//        sut?.getRetire("something")
//        XCTAssertNotEqual(sut?.fastestLapCounter, 1)
//    }
//    
//    // MARK: - Best Finish
//    
//    func testCheckingCounterBestFinishThatItsZero() {
//        guard let randomPosition = [(1...20).randomElement()].first,
//              let position = randomPosition else { return }
//        
//        sut?.getBestFinish(position)
//        
//        XCTAssertEqual(sut?.bestFinishCounter, position)
//    }
//    
//    func testCheckingCounterBestFinishThatItsMoreThanPosition() {
//        guard let randomFinish = [(11...20).randomElement()].first,
//              let randomCounter = randomFinish else { return }
//        
//        guard let randomPosition = [(1...10).randomElement()].first,
//              let position = randomPosition else { return }
//        
//        sut?.bestFinishCounter = randomCounter
//        sut?.getBestFinish(position)
//        
//        XCTAssertEqual(sut?.bestFinishCounter, position)
//    }
//    
//    // MARK: - Best Grid
//    
//    func testCheckingCounterBestGridThatItsZero() {
//        guard let randomGrid = [(1...20).randomElement()].first,
//              let grid = randomGrid else { return }
//        
//        sut?.getBestGrid(grid)
//        
//        XCTAssertEqual(sut?.bestGridCounter, grid)
//    }
//    
//    func testCheckingCounterBestGridThatItsNotZeroAndMoreThanGrid() {
//        guard let counter = [(11...20).randomElement()].first,
//              let randomCounter = counter else { return }
//        
//        guard let randomGrid = [(1...10).randomElement()].first,
//              let grid = randomGrid else { return }
//        
//        sut?.bestGridCounter = randomCounter
//        sut?.getBestGrid(grid)
//        
//        XCTAssertEqual(sut?.bestGridCounter, grid)
//    }
//    
//    // MARK: - Achievement (win, podium)
//    
//    func testCheckExistWinAndPodiumAndNotZero() {
//        sut?.getCurrentAchievement("1")
//        XCTAssertEqual(sut?.winCounter, sut?.podiumCounter)
//        XCTAssertNotEqual(sut?.winCounter, 0)
//        XCTAssertNotEqual(sut?.podiumCounter, 0)
//    }
//    
//    func testCheckExistPodiumButThereIsNoWin() {
//        guard let randomPodium = ["2", "3"].randomElement() else { return }
//        
//        sut?.getCurrentAchievement(randomPodium)
//        
//        XCTAssertEqual(sut?.winCounter, 0)
//        XCTAssertNotEqual(sut?.podiumCounter, 0)
//        XCTAssertNotEqual(sut?.winCounter, sut?.podiumCounter)
//    }
//    
//    // MARK: - Data with Driver and Race Count
//    
//    func testCheckExistDriverAndRaceNotZero() {
//        let res: [ResultF1] = []
//        
//        sut?.getDataWith(driver: res)
//        
//        XCTAssertEqual(sut?.raceCounter, 1)
//    }
//}



