//
//  HistoricalPickerViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalPickerViewModel {
    
    // MARK: - Public Properties
    
    weak var delegate: HistoricalPickerSelectedDelegate?
    
    // MARK: - Private Properties
    
    private var pickerResult = HistoricalPickerResult(totalSeasons: nil, championships: [], detailedResult: ["All"])
    private var resultsID = ["All"] // в будущем убрать
    
    // MARK: - Private Methods
    
    func sendValueFromPicker(by state: HistoricalPickerSelected, and row: Int) {
        switch state {
        case .yearChampionship:
            let selectedValue = pickerResult.championships[row]
            delegate?.year(currentСhampionship: selectedValue)
        case .category:
            let selectedСategory = pickerResult.category[row]
            delegate?.category(current: selectedСategory)
        case .detailedResult:
            let selectedValue = pickerResult.detailedResult[row]
            delegate?.detailed(currentResult: selectedValue)
        }
    }
    
    func selectedRowPicker(from values: [String?], by state: HistoricalPickerSelected) -> Array<Int>.Index {
        switch state {
        case .yearChampionship:
            if let year = Int(values[state.rawValue] ?? "2020"),
               let index = pickerResult.championships.firstIndex(of: year) {
                return index
            }
        case .category:
            if let category = values[0],
               let index = pickerResult.category.firstIndex(of: category) {
                return index
            }
        case .detailedResult:
            if let result = values[state.rawValue],
               let index = pickerResult.detailedResult.firstIndex(of: result) {
                return index
            }
        }
        return 0
    }
    
    func requestForSelection(from values: [String?], by state: HistoricalPickerSelected, compeletion: @escaping () -> (Void)) {
        switch state {
        case .yearChampionship:
            requestSeason(compeletion: compeletion)
        case .category:
            compeletion()
        case .detailedResult:
            requestDriverOrTeamOrRaceData(from: values, by: state, compeletion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func getChampionshipYear() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if let string = pickerResult.totalSeasons, let convertedYearCount = Int(string) {
            for i in 0...convertedYearCount - 1 {
                let year = currentYear - i
                pickerResult.championships.append(year)
            }
        }
    }
    
    private func requestSeason(compeletion: @escaping () -> (Void)) {
        API.requestYearChampionship { [weak self] (dates, error) in
            self?.pickerResult.totalSeasons = dates?.championship.yearsCount
            self?.getChampionshipYear()
            compeletion()
        }
    }
    
    private func requestDriverOrTeamOrRaceData(from values: [String?], by state: HistoricalPickerSelected, compeletion: @escaping () -> (Void)) {
        let type = values[state.rawValue - 1]?.lowercased()
        guard let year = values[state.rawValue - state.rawValue] else { return }
        
        if type == HistoricalCategory.drivers.rawValue {
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
                
                self?.pickerResult.detailedResult += driver
                self?.resultsID += driversID
                
                compeletion()
            }
        } else if type == HistoricalCategory.teams.rawValue {
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
                
                self?.pickerResult.detailedResult += constructorsName
                self?.resultsID += constructorsID
                
                compeletion()
            }
        } else {
            API.requestGrandPrix(year: year) { [weak self] (grandPrix, error) in
                guard let grandPrixes = grandPrix?.сrucitData.grandPrix.races.compactMap({ $0.raceName })
                else {
                    return
                }
                guard let roundGP = grandPrix?.сrucitData.grandPrix.races.compactMap({ $0.round })
                else {
                    return
                }
                
                self?.pickerResult.detailedResult += grandPrixes
                self?.resultsID += roundGP
                
                compeletion()
            }
        }
    }
}

// MARK: - Extension PickerViewModelType

extension HistoricalPickerViewModel: PickerViewModelType {
    
    func numberOfRowsInComponent(_ component: Int, by state: HistoricalPickerSelected) -> Int {
        switch state {
        case .yearChampionship:
            return pickerResult.championships.count
        case .category:
            return pickerResult.category.count
        case .detailedResult:
            return pickerResult.detailedResult.count
        }
    }
    
    func titleForRow(_ row: Int, by state: HistoricalPickerSelected) -> String? {
        switch state {
        case .yearChampionship:
            return String(pickerResult.championships[row])
        case .category:
            return pickerResult.category[row]
        case .detailedResult:
            return pickerResult.detailedResult[row]
        }
    }
    
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any], by state: HistoricalPickerSelected) -> NSAttributedString {
        var title = title
        
        switch state {
        case .yearChampionship:
            title = NSAttributedString(string: String(pickerResult.championships[row]), attributes: attributes)
            return title
        case .category:
            title = NSAttributedString(string: pickerResult.category[row], attributes: attributes)
            return title
        case .detailedResult:
            title = NSAttributedString(string: pickerResult.detailedResult[row], attributes: attributes)
            return title
        }
    }
}
