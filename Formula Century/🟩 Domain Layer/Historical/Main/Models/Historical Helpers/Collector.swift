//
//  Collector.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Collector {
    // Header
    let driverStandingsHeader        = HistoricalStandingsHeader("POS", "Driver", "Constructor", "Points")
    let constructorStandingsHeader   = HistoricalStandingsHeader("POS", "Constructor", "Points")
    let firstPlaceResultInRaceHeader = HistoricalStandingsHeader("Grand Prix", "Winner", "Car")
    let racesDetailDriverHeader      = HistoricalStandingsHeader("Grand Prix", "POS", "Time", "Points")
    let racesDetailConstructorHeader = HistoricalStandingsHeader("Grand Prix", "Drivers", "POS", "Time", "Points")
    let racesDetailHeader            = HistoricalStandingsHeader("POS", "Drivers", "Time", "Points")
    
    // Table
    var driverStandings: [DriverStandings] = []
    var constructorStandings: [ConstructorStandings] = []
    var firstPlaceResultInRace: [Race] = []
    var racesDetailDriver: [Race] = []
    var racesDetailConstructors: [Race] = []
    var racesDetail: [ResultF1] = []
}
