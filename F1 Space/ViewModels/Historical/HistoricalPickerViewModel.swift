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
    
    private var pickerResult = HistoricalPickerResult(totalSeasons: nil,
                                                      championships: [],
                                                      detailedResult: ["All"],
                                                      detailedResultID: ["All"])
    
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
            let selectedID = pickerResult.detailedResultID[row]
            delegate?.detailed(currentResult: selectedValue, id: selectedID)
        }
    }
    
    func selectedRowPicker(from values: [String?], by state: HistoricalPickerSelected) -> Array<Int>.Index {
        switch state {
        case .yearChampionship:
            if let year = values[state.rawValue],
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
    
    let detailIndex = 1
    let categoryIndex = 2
    
    func requestForSelection(from values: [String?], by state: HistoricalPickerSelected, compeletion: @escaping () -> (Void)) {
        switch state {
        case .yearChampionship:
            requestSeason(values: values, compeletion: compeletion)
        case .category:
            compeletion()
        case .detailedResult:
            requestDriverOrTeamOrRaceData(from: values, by: state, compeletion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func getChampionshipYear(temporaryMinus: Int) {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if let string = pickerResult.totalSeasons, let convertedYearCount = Int(string) {
            for i in 0...convertedYearCount - temporaryMinus {
                let year = currentYear - i
                pickerResult.championships.append(String(year))
            }
        }
    }
    
    private func requestSeason(values: [String?], compeletion: @escaping () -> (Void)) {
        guard let category = values[categoryIndex]?.lowercased() else { return }
        
        if category == HistoricalCategory.drivers.rawValue {
            temporaryStorageDriver(values: values, compeletion: compeletion)
        } else if category == HistoricalCategory.teams.rawValue {
            temporaryStorageConstructor(values: values, compeletion: compeletion)
        } else {
            print(values)
            if values[detailIndex] == "All" {
                API.requestSeasons { [weak self] (dates, error) in
                    self?.pickerResult.totalSeasons = dates?.championshipData.total
                    self?.getChampionshipYear(temporaryMinus: 1)
                    compeletion()
                }
            } else {
                API.requestSeasons { [weak self] (dates, error) in
                    self?.pickerResult.totalSeasons = dates?.championshipData.total
                    self?.getChampionshipYear(temporaryMinus: 1)
                    compeletion()
                }
            }
        }
    }
    
    func temporaryStorageConstructor(values: [String?], compeletion: @escaping () -> (Void)) {
        if values[detailIndex] == "All" {
            API.requestSeasonsOfficialConstructorsCup { [weak self] (constructorsYear, error) in
                self?.pickerResult.totalSeasons = constructorsYear?.twoOptionsData.total
                self?.getChampionshipYear(temporaryMinus: 0)
                compeletion()
            }
        } else {
            guard let identity = values[detailIndex] else { return }
            
            API.requestCurrentConstructorStandings { [weak self] (currentConstructorsYear, error) in
                guard let checkID = currentConstructorsYear?
                        .currentConstructorStandingsData
                        .currentConstructorStandingsTable
                        .currentConstructorStandingsLists.first?
                        .constructorStandings.compactMap({ $0.constructor.constructorID }) else {
                    return
                }
                
                guard let checkedCurrentSeason = currentConstructorsYear?
                        .currentConstructorStandingsData
                        .currentConstructorStandingsTable
                        .currentConstructorStandingsLists.first?
                        .season else {
                    return
                }
                
                if checkID.contains(identity) {
                    API.requestConstructorParticipated(id: identity) { [weak self] (takePart, err) in
                        
                        var correctTakePartConstructorYear = [String]()
                        
                        
                        guard let currentTakePartConstructor = takePart?
                                .constructorParticipatedData
                                .constructorParticipatedTable
                                .constructorParticipatedList
                                .compactMap({ $0.season })
                                .sorted(by: { $0 > $1 }) else {
                            return
                        }
                        
                        correctTakePartConstructorYear.append(checkedCurrentSeason)
                        correctTakePartConstructorYear.append(contentsOf: currentTakePartConstructor)
                        
                        self?.pickerResult.championships = correctTakePartConstructorYear
                        compeletion()
                    }
                } else {
                    API.requestConstructorParticipated(id: identity) { [weak self] (takePart, err) in
                        
                        guard let currentTakePartDriver = takePart?
                                .constructorParticipatedData
                                .constructorParticipatedTable
                                .constructorParticipatedList
                                .compactMap({ $0.season })
                                .sorted(by: { $0 > $1 }) else {
                            return
                        }
                        
                        self?.pickerResult.championships = currentTakePartDriver
                        compeletion()
                    }
                }
            }
        }
    }
    
    func temporaryStorageDriver(values: [String?], compeletion: @escaping () -> (Void)) {
        if values[detailIndex] == "All" {
            API.requestSeasons { [weak self] (dates, error) in
                self?.pickerResult.totalSeasons = dates?.championshipData.total
                self?.getChampionshipYear(temporaryMinus: 1)
                compeletion()
            }
        } else {
            guard let identity = values[detailIndex] else { return }
            
            API.requestCurrentDriverStandings { [weak self] (currentDriverStandings, err) in
                guard let checkID = currentDriverStandings?
                        .currentDriverStandingsData
                        .currentDriverStandingsTable
                        .currentDriverStandingsLists.first?
                        .driverStandings.compactMap({ $0.driver.driverID }) else {
                    return
                }
                
                guard let checkedCurrentSeason = currentDriverStandings?
                        .currentDriverStandingsData
                        .currentDriverStandingsTable
                        .currentDriverStandingsLists.first?
                        .season else {
                    return
                }
                
                if checkID.contains(identity) {
                    API.requestDriverParticipated(id: identity) { [weak self] (takePart, err) in
                        
                        var correctTakePartDriverYear = [String]()
                        
                        guard let currentTakePartDriver = takePart?.twoOptionsData
                                .driverParticipatedTable
                                .driverParticipatedList
                                .compactMap({ $0.season })
                                .sorted(by: { $0 > $1 }) else {
                            return
                        }
                        
                        correctTakePartDriverYear.append(checkedCurrentSeason)
                        correctTakePartDriverYear.append(contentsOf: currentTakePartDriver)
                        
                        self?.pickerResult.championships = correctTakePartDriverYear
                        compeletion()
                    }
                } else {
                    API.requestDriverParticipated(id: identity) { [weak self] (takePart, err) in
                        guard let currentTakePartDriver = takePart?.twoOptionsData
                                .driverParticipatedTable
                                .driverParticipatedList
                                .compactMap({ $0.season })
                                .sorted(by: { $0 > $1 })
                        else {
                            return
                        }
                        
                        self?.pickerResult.championships = currentTakePartDriver
                        compeletion()
                    }
                }
            }
        }
    }
    
    private func requestDriverOrTeamOrRaceData(from values: [String?], by state: HistoricalPickerSelected, compeletion: @escaping () -> (Void)) {
        let type = values[state.rawValue - 1]?.lowercased()
        guard let year = values[state.rawValue - state.rawValue] else { return }
        
        if type == HistoricalCategory.drivers.rawValue {
            API.requestDriverStandings(year: year) { [weak self] (driver, error) in
                let drivers = driver?.driverStandingsData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
                
                guard let driver = drivers?.reduce([], +).compactMap({ $0.driver.givenName + " " + $0.driver.familyName })
                else {
                    return
                }
                guard let driversID = drivers?.reduce([], +).compactMap({ $0.driver.driverID })
                else {
                    return
                }

                self?.pickerResult.detailedResult += driver
                self?.pickerResult.detailedResultID += driversID
                
                compeletion()
            }
        } else if type == HistoricalCategory.teams.rawValue {
            API.requestConstructorStandings(year: year) { [weak self] (constructorz, error) in
                let constructors = constructorz?
                    .constructorStandingsData
                    .constructorStandingsTable
                    .constructorStandingsLists.compactMap { $0.constructorStandings }
                
                guard let constructorsName = constructors?.reduce([], +).compactMap({ $0.constructor.name })
                else {
                    return
                }
                guard let constructorsID = constructors?.reduce([], +).compactMap({ $0.constructor.constructorID })
                else {
                    return
                }
                
                self?.pickerResult.detailedResult += constructorsName
                self?.pickerResult.detailedResultID += constructorsID
                
                compeletion()
            }
        } else {
            API.requestFirstPlaceResultInSeason(year: year) { [weak self] (grandPrix, error) in
                guard let grandPrixes = grandPrix?.raceResultData.raceResultTable.races.compactMap({ $0.raceName })
                else {
                    return
                }
                guard let roundGP = grandPrix?.raceResultData.raceResultTable.races.compactMap({ $0.round })
                else {
                    return
                }

                self?.pickerResult.detailedResult += grandPrixes
                self?.pickerResult.detailedResultID += roundGP
                
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
