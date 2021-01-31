//
//  HistoricalHeaderViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalHeaderViewModel {
    
    // MARK: - Public Properties
    
    var first:  String?
    var second: String?
    var third:  String?
    var fourth: String?
    var fifth:  String?
    var sixth:  String?
    
    // MARK: - Private Properties
    
    private var historicalStandingsHeader: HistoricalStandingsHeader?
    
    // MARK: - Constructors
    
    init(for different: HistoricalStandingsHeader?, by category: HistoricalCategory?, and id: String?) {
        self.historicalStandingsHeader = different
        setup(category: category, id: id)
    }

    // MARK: Private Methods
    
    private func setup(category: HistoricalCategory?, id: String?) {
        switch category {
        case .drivers: driverHeader(by: id)
        case .teams:   constructorHeader(by: id)
        case .races:   raceHeader(by: id)
        default:       fatalError("Unknown error \(#function)")
        }
    }
    
    private func driverHeader(by id: String?) {
        switch id.isAll() {
        case true:
            definingNumber(4)
        case false:
            definingNumber(4)
        }
    }
    
    private func constructorHeader(by id: String?) {
        switch id.isAll() {
        case true:
            definingNumber(3)
        case false:
            definingNumber(5)
        }
    }
    
    private func raceHeader(by id: String?) {
        switch id.isAll() {
        case true:
            definingNumber(3)
        case false:
            definingNumber(4)
        }
    }
    
    private func definingNumber(_ values: Int) {
        switch values {
        case _:
            first = historicalStandingsHeader?.firstHead
            second = historicalStandingsHeader?.secondHead
            third = historicalStandingsHeader?.thirdHead
            if values == 3 { break }
            else { fallthrough }
        case 4:
            fourth = historicalStandingsHeader?.fourthHead
            if values == 5 || values == 6 { fallthrough }
        case 5:
            fifth = historicalStandingsHeader?.fifthHead
            if values == 6 { fallthrough }
        case 6:
            sixth = historicalStandingsHeader?.sixthHead
        default:
            fatalError("This shouldn't happen at all! Func: \(#function)")
        }
    }
}

