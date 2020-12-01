//
//  HistoricalPickerViewModelTests.swift
//  F1 SpaceTests
//
//  Created by Nikita Sukachev on 30.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import XCTest
@testable import F1_Space

class HistoricalPickerViewModelTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testСheckingGettingTheNumberOfSeasons() {
        let sut = HistoricalPickerViewModel(currentValues: [], by: nil)
        sut.pickerResult = HistoricalPickerResult(
            totalSeasons: "10",
            championships: [],
            detailedResult: [],
            detailedResultID: []
        )
        
        sut.getChampionshipYear(num: 1)
        
        XCTAssertEqual(sut.pickerResult.championships.count, 10)
    }
}
