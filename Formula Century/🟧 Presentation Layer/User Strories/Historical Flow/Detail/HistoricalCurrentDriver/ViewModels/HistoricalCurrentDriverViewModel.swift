//
//  HistoricalCurrentDriverViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalCurrentDriverViewModel: HistoricalDetailViewModelVariety {
    
    // MARK: - Public Properties
    
    let driverStandings: DriverStandings
    let season: String
    let driverStandingsInput: HistoricalCurrentDriverInput
    
    var currentDriver: CurrentDriver?
    
    var closure: (() -> (Void))?
    
    // MARK: - Private Properties
    
    
    // MARK: - Constructors
    
    init(driverStandings: DriverStandings, season: String) {
        self.driverStandings = driverStandings
        self.season = season
        
        self.driverStandingsInput = HistoricalCurrentDriverUseCase(season: season, driverStandings: driverStandings)
        self.driverStandingsInput.subscribe(with: self)
    }
    
    // MARK: - Public Methods
    
    func reload() {
        self.driverStandingsInput.requestInfoAboutDriver()
    }
    
    // MARK: - Private Methods
    
}

// MARK: - HistoricalCurrentDriverViewModelType

extension HistoricalCurrentDriverViewModel: HistoricalCurrentDriverViewModelType {
    func numberOfRows() -> Int {
        return currentDriver?.comparison.driverItems[AppKey.qualification.rawValue]?.count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> DuelViewModelCell {
        return DuelViewModelCell(driverItems: currentDriver, indexPath: indexPath, driverID: driverStandings.driver.driverID)
    }
}

// MARK: - HistoricalCurrentDriverOutput

extension HistoricalCurrentDriverViewModel: HistoricalCurrentDriverOutput {
    func loaded(_ model: CurrentDriver) {
        self.currentDriver = model
        closure?()
    }
    
    func getError(_ error: Error?) {
        // print(error?.localizedDescription)
    }
}
