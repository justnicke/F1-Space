//
//  ConfigurationModelTests.swift
//  Formula CenturyTests
//
//  Created by Nikita Sukachev on 22.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import XCTest
@testable import Formula_Century

final class ConfigurationModelTests: XCTestCase {

    private var sut: CheckingType?
    
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }



    func test_AAA() {
        let mock = ConfigurationModelMock()
        mock.polePosition("1")
        
        XCTAssertEqual(mock.counter, 1)
        
    }
    
}


class ConfigurationModelMock: CheckingType {
    var counter = 0
    
    func getPolePosition(_ grid: String) {
        if grid == "1" {
            self.counter += 1
        }
    }
}
