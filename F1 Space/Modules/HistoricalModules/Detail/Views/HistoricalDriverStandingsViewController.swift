//
//  HistoricalDriverStandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverStandingsViewController: BaseHistoricalDetailViewController<HistoricalDriverStandingsViewModel> {
    
    override init(viewModel: HistoricalDriverStandingsViewModel?) {
        self.driver = viewModel?.driverID ?? ""
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var items: [String : [[String : Int]]] = [:]
    
    var res = [[ResultF1]]()
    
    let duelView = DuelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(duelView)
        duelView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                        padding: .init(top: 200, left: 20, bottom: 0, right: 20),
                        size: .init(width: 0, height: 120))
        

        testFunc()
    }
    
    let semaphore = DispatchSemaphore(value: 0)

    func testFunc() {
        guard let driver = self.viewModel?.driverID else { return }
        guard let constID = self.viewModel?.constructorsID else { return }
        var counter = 0
        
        DispatchQueue.global(qos: .utility).async {
            for id in constID {
                API.requestConstructorDetailResult(year: "2020", id: id) { [weak self] (const, err) in
                    
                    guard let results = const?.constructorDetailData.constructorDetailTable.races.map({ $0.results }) else { return }
                    
                    for (_, res) in results.enumerated() {
                        // statistics of current season
                        for i in res {
                            if i.driver.driverID.contains(driver) {
                                // position
                                if i.position == "1" {
                                    self?.winCount += 1
                                    self?.podiumCount += 1
                                } else if i.position == "2" || i.position == "3" {
                                    self?.podiumCount += 1
                                }
                                
                                // pole or grid
                                if i.grid == "1" {
                                    self?.poleCount += 1
                                }
                                
                                // bestGrid
                                if let bestG = Int(i.grid) {
                                    if self?.bestGrid == 0 {
                                        self?.bestGrid = bestG
                                    } else if bestG != 0 && self!.bestGrid > bestG {
                                        self?.bestGrid = bestG
                                    }
                                }
                                
                                // bestFinish
                                if let bestF = Int(i.position) {
                                    if self?.bestFinish == 0 {
                                        self?.bestFinish = bestF
                                    } else if self!.bestFinish > bestF {
                                        self?.bestFinish = bestF
                                    }
                                }
                                
                                // retire
                                if i.positionText == "R" {
                                    self?.numOfRetire += 1
                                }
                                
                                // permanentNumber
                                self?.permanentNumber = i.driver.permanentNumber
                                
                                // nationality
                                self?.nationality = i.driver.nationality
                                
                                // fastestLap
                                if i.fastestLap?.rank == "1" {
                                    self?.fastestLapCount += 1
                                }
                            }
                        }
                        
                        // Get data with selected driver and teammate
                        let trueOrFalse = res.compactMap ({ $0.driver.driverID.contains(driver) })
                        
                        if trueOrFalse.contains(true) {
                            self?.numOfRace += 1
                            self?.res.append(res)
                        }
                    }
                    
                    counter += 1
                    
                    if counter == constID.count  {
                        self?.semaphore.signal()
                    }
                }
            }
            
            self.semaphore.wait()
            self.testDict(res: self.res)
            print(self.items)
        }
    }
    
    var numOfRace = 0
    var winCount = 0
    var podiumCount = 0
    var poleCount = 0
    var bestFinish = 0
    var bestGrid = 0
    var numOfRetire = 0
    var permanentNumber = ""
    var nationality = ""
    var fastestLapCount = 0
    
    // name
    var driver: String
    var teammate = ""

    // quali
    var driverQuali = 0
    var teammateQuali = 0
    // race
    var driverRace = 0
    var teammateRace = 0
    
    
    func testDict(res: [[ResultF1]]) {
        var supprots: [String] = []
        
        for (_, array) in res.enumerated() {
            for i in array {
                if i.driver.driverID != driver {
                    supprots.append(i.driver.driverID)
                }
            }
        }
        
        let teammates = supprots.dropDuplicates()
        
        for (_, teammate) in teammates.enumerated() {
            if items.isEmpty {
                items["qualification"] = [[driver : driverQuali, teammate: teammateQuali]]
                items["race"] = [[driver : driverRace, teammate: teammateRace]]
            } else {
                items["qualification"]?.append([driver : driverQuali, teammate: teammateQuali])
                items["race"]?.append([driver : driverRace, teammate: teammateRace])
            }
        }
            
        for (_, array) in res.enumerated() {
            for i in array {
         
                if i.driver.driverID == driver {
                    driver = i.driver.driverID
                    driverQuali = Int(i.grid) ?? 0
                    driverRace = Int(i.position) ?? 0
                } else {
                    teammate = i.driver.driverID
                    teammateQuali = Int(i.grid) ?? 0
                    teammateRace = Int(i.position) ?? 0
                }
            }
            
            if driverQuali < teammateQuali {
                driverQuali = 0
                teammateQuali = 0
                driverQuali += 1
            } else {
                teammateQuali = 0
                driverQuali = 0
                teammateQuali += 1
            }
            
            if driverRace < teammateRace {
                driverRace = 0
                teammateRace = 0
                driverRace += 1
            } else {
                teammateRace = 0
                driverRace = 0
                teammateRace += 1
            }
            
            for (i,e) in items["qualification"]!.enumerated()  {
                if e.keys.contains(teammate) {
                    items["qualification"]?[i][driver]! += driverQuali
                    items["qualification"]?[i][teammate]! += teammateQuali
                    
                    items["race"]?[i][driver]! += driverRace
                    items["race"]?[i][teammate]! += teammateRace
                }
            }
        }
    }
}
