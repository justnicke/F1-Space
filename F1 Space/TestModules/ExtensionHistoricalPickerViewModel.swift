//
//  ExtensionHistoricalPickerViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

// MARK: - Year Picker (1)

 extension HistoricalPickerViewModel {
    
    /// Auxiliary index for providing a value from the "currentValues" array
    enum HIndex: Int {
        /// Picker Year
        case year = 0
        /// Picker Detail
        case detail = 1
        /// Picker Category
        case category = 2
        /// Validity of the first race
        case startSeason
    }
    
    func requestSeason(completion: @escaping () -> (Void)) {
        guard let category = currentValues[HIndex.category.rawValue]?.lowercased() else { return }
        
        if category == HistoricalCategory.drivers.rawValue {
            requestYearDataForDriver(completion: completion)
        } else if category == HistoricalCategory.teams.rawValue {
            requestYearDataForConstructor(completion: completion)
        } else {
            requestYearDataForRace(completion: completion)
        }
    }
    
    /// Provides  years
    ///
    /// - Parameter num: Managing the number helps you get the correct year for each model
    func getChampionshipYear(num: Int) {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if currentValues[HIndex.startSeason.rawValue] == "false"  {
            if let string = pickerResult.totalSeasons, let convertedYearCount = Int(string) {
                for i in 1..<convertedYearCount + num {
                    let year = currentYear - i
                    
                    pickerResult.championships.append(String(year))
                }
            }
        } else {
            if let string = pickerResult.totalSeasons, let convertedYearCount = Int(string) {
                for i in 0..<convertedYearCount + num {
                    let year = currentYear - i
                    
                    pickerResult.championships.append(String(year))
                }
            }
        }
    }
    
    private func requestYearDataForDriver(completion: @escaping () -> (Void)) {
        switch currentValues[HIndex.detail.rawValue].isAll() {
        case true:
            API.requestSeasons { [weak self] (totalYears, error) in
                self?.pickerResult.totalSeasons = totalYears?.championshipData.total
                self?.getChampionshipYear(num: 0)
                completion()

            }
        case false:
            let identity = currentValues[HIndex.detail.rawValue].unwrap.lowercased()
            
            API.requestCurrentDriverStandings { [weak self] (currentDriverStandings, err) in
                let checkID = currentDriverStandings?
                    .currentDriverStandingsData
                    .currentDriverStandingsTable
                    .currentDriverStandingsLists.first?
                    .driverStandings
                    .compactMap { $0.driver.driverID }
                
                let checkedCurrentSeason = currentDriverStandings?
                    .currentDriverStandingsData
                    .currentDriverStandingsTable
                    .currentDriverStandingsLists.first?
                    .season
            
                if checkID.unwrap.contains(identity) {
                    API.requestDriverParticipated(id: identity) { [weak self] (participated, err) in
                        var correctTakePartDriverYear = [String]()
                        let currentTakePartDriver = participated?
                            .twoOptionsData
                            .driverParticipatedTable
                            .driverParticipatedList
                            .compactMap({ $0.season })

                        correctTakePartDriverYear.append(checkedCurrentSeason.unwrap)
                        correctTakePartDriverYear.append(contentsOf: currentTakePartDriver.unwrap)
                        
                        self?.pickerResult.championships = correctTakePartDriverYear.dropDuplicates().sorted(by: { $0 > $1 })
                        completion()
                    }
                }
                else {
                    API.requestDriverParticipated(id: identity) { [weak self] (participated, err) in
                        let currentTakePartDriver = participated?
                            .twoOptionsData
                            .driverParticipatedTable
                            .driverParticipatedList
                            .compactMap({ $0.season })
                            .sorted(by: { $0 > $1 })
                        
                        self?.pickerResult.championships = currentTakePartDriver.unwrap
                        completion()
                    }
                }
            }
        }
    }
    
    private func requestYearDataForConstructor(completion: @escaping () -> (Void)) {
        switch currentValues[HIndex.detail.rawValue].isAll() {
        case true:
            API.requestSeasonsOfficialConstructorsCup { [weak self] (totalYears, error) in
                self?.pickerResult.totalSeasons = totalYears?.twoOptionsData.total
                self?.getChampionshipYear(num: 1)
                completion()
            }
        case false:
            let identity = currentValues[HIndex.detail.rawValue].unwrap
            
            API.requestCurrentConstructorStandings { [weak self] (currentConstructorsStandings, error) in
                let checkID = currentConstructorsStandings?
                    .currentConstructorStandingsData
                    .currentConstructorStandingsTable
                    .currentConstructorStandingsLists.first?
                    .constructorStandings
                    .compactMap({ $0.constructor.constructorID })
                
                let checkedCurrentSeason = currentConstructorsStandings?
                    .currentConstructorStandingsData
                    .currentConstructorStandingsTable
                    .currentConstructorStandingsLists.first?
                    .season
                
                if checkID.unwrap.contains(identity) {
                    API.requestConstructorParticipated(id: identity) { [weak self] (participated, err) in
                        var correctTakePartConstructorYear = [String]()
                        let currentTakePartConstructor = participated?
                            .constructorParticipatedData
                            .constructorParticipatedTable
                            .constructorParticipatedList
                            .compactMap({ $0.season })
                        
                        correctTakePartConstructorYear.append(checkedCurrentSeason.unwrap)
                        correctTakePartConstructorYear.append(contentsOf: currentTakePartConstructor.unwrap)
                        
                        self?.pickerResult.championships = correctTakePartConstructorYear.dropDuplicates().sorted(by: { $0 > $1 })
                        completion()
                    }
                } else {
                    API.requestConstructorParticipated(id: identity) { [weak self] (participated, err) in
                        let currentTakePartDriver = participated?
                            .constructorParticipatedData
                            .constructorParticipatedTable
                            .constructorParticipatedList
                            .compactMap({ $0.season })
                            .sorted(by: { $0 > $1 })
                        
                        self?.pickerResult.championships = currentTakePartDriver.unwrap
                        completion()
                    }
                }
            }
        }
    }
    
    private func requestYearDataForRace(completion: @escaping () -> (Void)) {
        API.requestSeasons { [weak self] (totalYears, error) in
            self?.pickerResult.totalSeasons = totalYears?.championshipData.total
            self?.getChampionshipYear(num: 0)
            completion()
        }
    }
 }

// MARK: - Detailed Result Picker (3)

extension HistoricalPickerViewModel {
    /// Data provided to the "Detailed Result" picker
    func selectedRequest(completion: @escaping () -> (Void)) {
        let typePicker = currentValues[state.unwrap.rawValue]?.lowercased()
        
        if typePicker == HistoricalCategory.drivers.rawValue {
            requestDriverDetailData(completion: completion)
        } else if typePicker == HistoricalCategory.teams.rawValue {
            requestConstructorDetailData(completion: completion)
        } else {
            requestRaceDetailData(completion: completion)
        }
    }
    
    private func requestDriverDetailData(completion: @escaping () -> (Void)) {
        let year = currentValues[state.unwrap.rawValue - state.unwrap.rawValue].unwrap
        
        API.requestDriverStandings(year: year) { [weak self] (driverStandings, error) in
            let ds = driverStandings?
                .driverStandingsData
                .driverStandingsTable
                .driverStandingsLists
                .flatMap({ $0.driverStandings })
            
            let driversFullName = ds?.compactMap { $0.driver.givenName + " " + $0.driver.familyName }
            let driversID = ds?.compactMap { $0.driver.driverID }
            
            
            self?.pickerResult.detailedResult += driversFullName.unwrap
            self?.pickerResult.detailedResultID += driversID.unwrap
            
            completion()
        }
    }
    
    private func requestConstructorDetailData(completion: @escaping () -> (Void)) {
        let year = currentValues[state.unwrap.rawValue - state.unwrap.rawValue].unwrap
        
        API.requestConstructorStandings(year: year) { [weak self] (constructorStandings, error) in
            let constructors = constructorStandings?
                .constructorStandingsData
                .constructorStandingsTable
                .constructorStandingsLists.flatMap({ $0.constructorStandings })
            
            let constructorsName = constructors?.compactMap { $0.constructor.name }
            let constructorsID = constructors?.compactMap { $0.constructor.constructorID }
            
            self?.pickerResult.detailedResult += constructorsName.unwrap
            self?.pickerResult.detailedResultID += constructorsID.unwrap
            
            completion()
        }
    }
    
    private func requestRaceDetailData(completion: @escaping () -> (Void)) {
        let year = currentValues[state.unwrap.rawValue - state.unwrap.rawValue].unwrap
        
        API.requestFirstPlaceResultInSeason(year: year) { [weak self] (races, error) in
            let racesName = races?
                .raceResultData
                .raceResultTable
                .races.compactMap({ $0.raceName })
            
            let racesRound = races?
                .raceResultData
                .raceResultTable
                .races
                .compactMap { $0.round }
            
            self?.pickerResult.detailedResult += racesName.unwrap
            self?.pickerResult.detailedResultID += racesRound.unwrap
            
            completion()
        }
    }
}
