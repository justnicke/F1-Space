//
//  HistoricalCurrentDriverUseCase.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 25.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCurrentDriverInput: AnyObject {
    func requestInfoAboutDriver()
    func subscribe(with output: HistoricalCurrentDriverOutput)
}

protocol HistoricalCurrentDriverOutput: AnyObject {
    func loaded(_ model: CurrentDriver)
    func getError(_ error: Error?)
}

final class HistoricalCurrentDriverUseCase: HistoricalCurrentDriverInput {
    
    // MARK: - Public Properties
    
    weak var output: HistoricalCurrentDriverOutput?
    
    // DriverStandingsResultCounterable
    
    var raceCounter       = 0
    var winCounter        = 0
    var podiumCounter     = 0
    var poleCounter       = 0
    var bestFinishCounter = 0
    var bestGridCounter   = 0
    var retireCounter     = 0
    var fastestLapCounter = 0
    var filteredResults   = [[ResultF1]]()
    
    // DriverStandingsItemsCounterable
    
    var driverQualiCounter   = 0
    var teammateQualiCounter = 0
    var driverRaceCounter    = 0
    var teammateRaceCounter  = 0
    var teammate = ""
    
    // DriverStandingsProperty
    
    var driverID: String
    var items: [String : [[String : Int]]] = [:]
    
    // MARK: - Private Properties
    
    private var constructorsID: [String]
    private var season: String
    private var driverFullName: String
    private var nationality: String
    private var number: String
    private var dateOfBirth: String
    private var constructors: String
    private let semaphore = DispatchSemaphore(value: 0)
    
    // MARK: - Constructors
    
    init(season: String, driverStandings: DriverStandings) {
        self.season         = season
        self.driverID       = driverStandings.driver.driverID
        self.driverFullName = driverStandings.driver.givenName + " " + driverStandings.driver.familyName
        self.nationality    = driverStandings.driver.nationality
        self.number         = driverStandings.driver.permanentNumber ?? ""
        self.dateOfBirth    = driverStandings.driver.dateOfBirth
        self.constructorsID = driverStandings.constructors.map({ $0.constructorID })
        self.constructors   = driverStandings.constructors.map({ $0.name }).joined(separator: " / ")
    }
    
    // MARK: - Public Methods
    
    func requestInfoAboutDriver() {
        var counter = 0
        
        DispatchQueue.global(qos: .utility).async {
            for id in self.constructorsID {
                API.requestConstructorDetailResult(year: self.season, id: id) { [weak self] (constructorDetail, error) in
                    
                    if let constructors = constructorDetail, error == nil {
                        let results = constructors.constructorDetailData.constructorDetailTable.races.map { $0.results }
                        
                        self?.configure(results)
                        
                        counter += 1
                        
                        if counter == self?.constructorsID.count  {
                            self?.semaphore.signal()
                        }
                        
                    } else {
                        self?.output?.getError(error)
                    }
                }
            }
            
            self.semaphore.wait()
            self.configureComparison(self.filteredResults)
            
            DispatchQueue.main.async {
                let currentDriver = self.setModel()
                self.output?.loaded(currentDriver)
            }
        }
    }
    
    func subscribe(with output: HistoricalCurrentDriverOutput) {
        self.output = output
    }
}
// MARK: - DriverStandingsConfiguratorType

extension HistoricalCurrentDriverUseCase: HistoricalCurrentDriverConfiguratorType {
    func setModel() -> CurrentDriver {
        let top = CurrentDriverTitle(
            fullName:        self.driverFullName,
            nationality:     self.nationality,
            number:          self.number,
            dateBirth:       self.dateOfBirth,
            constructorName: self.constructors,
            season:          self.season
        )
        
        let middle = CurrentDriverComparison(driverItems: self.items)
        
        let bottom = CurrentDriverDescription(
            race:       self.raceCounter.toString(),
            win:        self.winCounter.toString(),
            podium:     self.podiumCounter.toString(),
            pole:       self.poleCounter.toString(),
            bestFinish: self.bestFinishCounter.toString(),
            bestGrid:   self.bestGridCounter.toString(),
            retire:     self.retireCounter.toString(),
            fastestLap: self.fastestLapCounter.toString()
        )
        
        return CurrentDriver(titile: top, comparison: middle, description: bottom)
    }
    
    func configure(_ results: [[ResultF1]]) {
        for (_, res) in results.enumerated() {
            for element in res {
                if element.driver.driverID.contains(self.driverID) {
                    self.getCurrentAchievement(element.position)
                    self.getBestGrid(Int(element.grid) ?? 0)
                    self.getBestFinish(Int(element.position) ?? 0)
                    self.getPolePosition(element.grid)
                    self.getFastestLap(element.fastestLap?.rank ?? "unknown")
                    self.getRetire(element.positionText)
                }
            }
            
            self.getDataWith(driver: res)
        }
    }
    
    func configureComparison(_ results: [[ResultF1]]) {
        let teammates = self.getTeammate(from: results).dropDuplicates()
        
        self.addedValueForItems(from: teammates)
        
        for res in results {
            self.getValueCounters(from: res)
            self.calculateQualifications()
            self.calculateRaces()
            
            guard let items = self.items[AppKey.qualification.rawValue]?.enumerated() else {
                return
            }
            
            self.reloadItems(items)
        }
    }
}

