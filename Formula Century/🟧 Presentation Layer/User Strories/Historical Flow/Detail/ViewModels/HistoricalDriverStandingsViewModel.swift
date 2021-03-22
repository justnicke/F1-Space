//
//  HistoricalDriverStandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalDriverStandingsViewModelType:
    HistoricalDriverStandingsViewModelDataSource {}

protocol HistoricalDriverStandingsViewModelDataSource {
    func numberOfRows() -> Int
    func cellForRowAt(indexPath: IndexPath) -> DuelViewModelCell?
}

final class DuelViewModelCell {
    
}

final class HistoricalDriverStandingsViewModel: HistoricalDetailViewModelVariety {
    let driverStandings: DriverStandings
    let season: String
    let driverStandingsInput: DriverStandingsInput
    
//    var closure: () -> (Void)
    
    
    init(driverStandings: DriverStandings, season: String) {
        self.driverStandings = driverStandings
        self.season = season
        
        self.driverStandingsInput = DriverStandingsUseCase()
        self.driverStandingsInput.subscribe(with: self)
    }
    
    func reload() {
        driverStandingsInput.tryTo(get: driverStandings, and: season)
    }
}

extension HistoricalDriverStandingsViewModel: HistoricalDriverStandingsViewModelType {
    func numberOfRows() -> Int {
        return 0 // передать словарь
    }
    
    func cellForRowAt(indexPath: IndexPath) -> DuelViewModelCell? {
        return DuelViewModelCell()
    }
}

// Данные загружаются в отдельный словарь а не в один, проблема в структуре
extension HistoricalDriverStandingsViewModel: DriverStandingsOutput {
    func loaded(model: ReadyModel) {
        print(model.bottom.win)
        print(model.bottom.podium)
        print(model.bottom.bestFinish)
    }
    
    func getError(_ error: Error?) {
        print(error?.localizedDescription)
    }
    
    
}



protocol DriverStandingsInput: AnyObject {
    func tryTo(get: DriverStandings, and season: String)
    func subscribe(with output: DriverStandingsOutput)
}

protocol DriverStandingsOutput: AnyObject {
    func loaded(model: ReadyModel)
    func getError(_ error: Error?)
}

final class DriverStandingsUseCase: DriverStandingsInput {
    
    weak var output: DriverStandingsOutput?
    
    func tryTo(get: DriverStandings, and season: String) {
        let constructorID = get.constructors.map { $0.constructorID }
        
        for id in constructorID {
            API.requestConstructorDetailResult(year: season, id: id) { (const, error) in
                if let constructors = const, error == nil {
                    
                    let results = constructors.constructorDetailData.constructorDetailTable.races.map { $0.results  }
                    let configureModel = ConfigurationModel(results: results, season: season, driverStandings: get)
                    let readyModel = configureModel.setup()
                    
                    
                    self.output?.loaded(model: readyModel)
                } else {
                    self.output?.getError(error)
                }
            }
        }
    }
    
    func subscribe(with output: DriverStandingsOutput) {
        self.output = output
    }
}


// Готовая модель для передачи во viewModel

struct ReadyModel {
    let top:    Top
    let middle: Middle
    let bottom: Bottom
}

struct Top {
    let fullName:        String
    let nationality:     String
    let number:          String
    let dateBirth:       String
    let constructorName: String
    let season:          String
}

struct Middle {
    let driverItems: [String : [[String : Int]]]
}

struct Bottom {
    var race:       String
    var win:        String
    var podium:     String
    var pole:       String
    var bestFinish: String
    var bestGrid:   String
    var retire:     String
    var fastestLap: String
}

extension Int {
    func toString() -> String {
        return String(self)
    }
}
