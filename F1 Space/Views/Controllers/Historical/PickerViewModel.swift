//
//  PickerViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class PickerViewModel {
    
    // MARK: - Public Properties
    
    weak var delegate: PickerTypeDelegate?
    
    // MARK: - Private Properties
    
    private var pickerResult = PickerResult(yearCount: nil, championships: [])
    private var resultsID = ["All"] // в будущем убрать
    
    // MARK: - Private Nested
    
    private enum SelectedType: String {
        case drivers, teams, races
    }
    
    // MARK: - Private Methods
    
    func sendValueFromPicker(by state: PickerIndex, and row: Int) {
        switch state {
        case .first:
            let selectedValue = pickerResult.championships[row]
            delegate?.year(value: selectedValue)
        case .second:
            let selectedValue = pickerResult.typeResults[row]
            delegate?.type(result: selectedValue)
        case .third:
            let selectedValue = pickerResult.listResults[row]
            delegate?.result(value: selectedValue)
        }
    }
    
    func selectedRowPicker(from values: [String?], by state: PickerIndex) -> Array<Int>.Index {
        switch state {
        case .first:
            if let year = Int(values[state.rawValue] ?? "2020"),
               let index = pickerResult.championships.firstIndex(of: year) {
                return index
            }
        case .second:
            if let typeResult = values[0],
               let index = pickerResult.typeResults.firstIndex(of: typeResult) {
                return index
            }
        case .third:
            if let result = values[state.rawValue],
               let index = pickerResult.listResults.firstIndex(of: result) {
                return index
            }
        }
        return 0
    }
    
    func requestForSelection(from values: [String?], by state: PickerIndex, compeletion: @escaping () -> (Void)) {
        switch state {
        case .first:
            requestSeason(compeletion: compeletion)
        case .second:
            compeletion()
        case .third:
            requestDriverTeamOrRaceData(arr: values, state: state, compeletion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func getChampionshipYear() {
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
    
    private func requestSeason(compeletion: @escaping () -> (Void)) {
        API.requestYearChampionship { [weak self] (dates, error) in
            self?.pickerResult.yearCount = dates?.championship.yearsCount
            self?.getChampionshipYear()
            compeletion()
        }
    }
    
    private func requestDriverTeamOrRaceData(arr: [String?], state: PickerIndex, compeletion: @escaping () -> (Void)) {
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
                guard let grandPrixes = grandPrix?.mrData.raceTable.races.compactMap({ $0.raceName })
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

// MARK: - Extension PickerViewModelType

extension PickerViewModel: PickerViewModelType {
    
    func numberOfRowsInComponent(_ component: Int, by state: PickerIndex) -> Int {
        switch state {
        case .first:
            return pickerResult.championships.count
        case .second:
            return pickerResult.typeResults.count
        case .third:
            return pickerResult.listResults.count
        }
    }
    
    func titleForRow(_ row: Int, by state: PickerIndex) -> String? {
        switch state {
        case .first:
            return String(pickerResult.championships[row])
        case .second:
            return pickerResult.typeResults[row]
        case .third:
            return pickerResult.listResults[row]
        }
    }
    
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any], by state: PickerIndex) -> NSAttributedString {
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
