//
//  PickerViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol PickerViewModelType {
    func numberOfRowsIn(state: Countering, component: Int) -> Int
    func titleFor(state: Countering, row: Int) -> String?
    func viewFor(state: Countering, row: Int, for title: NSAttributedString, and attributes: [NSAttributedString.Key : Any]) -> NSAttributedString
}


final class PickerViewModel {
    
    var pickerResult = PickerResult(yearCount: nil, championships: [])

    weak var delegate: PickerTypeDelegate?
    
    var resultsID = ["All"]
    
    private enum SelectedType: String {
        case drivers, teams, races
    }
    
    func getChampionshipYear() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if let string = pickerResult.yearCount, let convertedYearCount = Int(string) {
            for i in 0...convertedYearCount - 1 {
                let year = currentYear - i
                pickerResult.championships.append(year)
            }
        }
    }
    
    func sendValueFromPicker(state: Countering, selectedRow: Int) {
        switch state {
        case .first:
            let selectedValue = pickerResult.championships[selectedRow]
            delegate?.year(value: selectedValue)
        case .second:
            let selectedValue = pickerResult.typeResults[selectedRow]
            delegate?.type(result: selectedValue)
        case .third:
            let selectedValue = pickerResult.listResults[selectedRow]
            delegate?.result(value: selectedValue)
        }
    }
    
    func selectedRowPicker(arr: [String?], state: Countering) -> Array<Int>.Index {
        switch state {
        case .first:
            if let year = Int(arr[state.rawValue] ?? "2020"),
               let index = pickerResult.championships.firstIndex(of: year) {
                return index
            }
        case .second:
            if let typeResult = arr[0],
               let index = pickerResult.typeResults.firstIndex(of: typeResult) {
                return index
            }
        case .third:
            if let result = arr[state.rawValue],
               let index = pickerResult.listResults.firstIndex(of: result) {
                return index
            }
        }
        return 0
    }
    
    func requestData(arr: [String?], state: Countering, compeletion: @escaping () -> (Void)) {
        switch state {
        case .first:
            requestSeason(compeletion: compeletion)
        case .second:
            compeletion()
        case .third:
            requestDriverTeamOrRaceData(arr: arr, state: state, compeletion: compeletion)
        }
    }
    
    func requestSeason(compeletion: @escaping () -> (Void)) {
    API.requestYearChampionship { [weak self] (dates, error) in
        self?.pickerResult.yearCount = dates?.championship.yearsCount
        self?.getChampionshipYear()
        compeletion()
    }
}
    
    func requestDriverTeamOrRaceData(arr: [String?], state: Countering, compeletion: @escaping () -> (Void)) {
    let type = arr[state.rawValue - 1]?.lowercased()
    guard let year = arr[state.rawValue - state.rawValue] else { return }
    
    if type == SelectedType.drivers.rawValue {
        API.requestDriverStandings(year: year) { [weak self] (driver, error) in
            let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            
            guard let driver = drivers?.reduce([], +).compactMap({ $0.driver.givenName + " " + $0.driver.familyName })
                else {
                    return
            }
            guard let driversID = drivers?.reduce([], +).compactMap({ $0.driver.driverID  })
                else {
                    return
            }
            
            self?.pickerResult.listResults += driver
            self?.resultsID += driversID
            
            compeletion()
        }
    } else if type == SelectedType.teams.rawValue {
        API.requestConstructorStandings(year: year) { [weak self] (constructor, error) in
            let constructors = constructor?
                .constructorData
                .constructorStandingsTable
                .constructorStandingsLists.compactMap { $0.constructorStandings }
            
            guard let constructorsName = constructors?.reduce([], +).compactMap({ $0.constructor.name })
                else {
                    return
            }
            guard let constructorsID = constructors?.reduce([], +).compactMap({ $0.constructor.constructorId })
                else {
                    return
            }
            
            self?.pickerResult.listResults += constructorsName
            self?.resultsID += constructorsID
            
            compeletion()
        }
    } else {
        API.requestGrandPrix(year: year) { [weak self] (grandPrix, error) in
            guard let grandPrixes =  grandPrix?.mrData.raceTable.races.compactMap({ $0.raceName })
                else {
                    return
            }
            guard let roundGP = grandPrix?.mrData.raceTable.races.compactMap({ $0.round })
                else {
                    return
            }
            
            self?.pickerResult.listResults += grandPrixes
            self?.resultsID += roundGP
            
            compeletion()
        }
    }
}

}

extension PickerViewModel: PickerViewModelType {
    func numberOfRowsIn(state: Countering, component: Int) -> Int {
        switch state {
        case .first:
            return pickerResult.championships.count
        case .second:
            return pickerResult.typeResults.count
        case .third:
            return pickerResult.listResults.count
        }
    }
    
    func titleFor(state: Countering, row: Int) -> String? {
        switch state {
        case .first:
            return String(pickerResult.championships[row])
        case .second:
            return pickerResult.typeResults[row]
        case .third:
            return pickerResult.listResults[row]
        }
    }
    
    func viewFor(state: Countering, row: Int, for title: NSAttributedString, and attributes: [NSAttributedString.Key : Any]) -> NSAttributedString {
        var title = title
        switch state {
        case .first:
            title = NSAttributedString(string: String(pickerResult.championships[row]), attributes: attributes)
            return title
        case .second:
            title = NSAttributedString(string: pickerResult.typeResults[row], attributes: attributes)
            return title
        case .third:
            title = NSAttributedString(string: pickerResult.listResults[row], attributes: attributes)
            return title
 
        }
    }
}
