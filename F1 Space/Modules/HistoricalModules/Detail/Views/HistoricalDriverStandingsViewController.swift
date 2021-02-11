//
//  HistoricalDriverStandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverStandingsViewController: UIViewController {
    
    var viewModel: HistoricalDriverStandingsViewModel?

    init(viewModel: HistoricalDriverStandingsViewModel?) {
        self.viewModel = viewModel
        self.driver = viewModel?.driverID ?? ""
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    var arrays = [[ResultF1]]()
    var items: [String : [[String : Int]]] = [:]
    
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
    
    func testFunc(){
        guard let driver = viewModel?.driverID else { return }
        guard let constID = viewModel?.constructorsID else { return }
        
//        var arrays = [[ResultF1]]()
        
        for id in constID {
            API.requestConstructorDetailResult(year: "2020", id: id) { [weak self] (const, err) in
                guard let results = const?.constructorDetailData.constructorDetailTable.races.map({ $0.results }) else { return }
                
                for res in results {
                    
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
                        self?.arrays.append(res)
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
//            print(self.arrays.map{$0.map{$0.grid}})
//            print(self.numOfRace)
//            print(self.winCount)
//            print(self.podiumCount)
//            print(self.poleCount)
//            print(self.bestFinish)
//            print(self.numOfRetire)
//            print(self.bestGrid)
//            print(self.nationality)
//            print(self.fastestLapCount)
            
            self.testDict(res: self.arrays)
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
    
    func testDict(res: [[ResultF1]]) {
        for (_, array) in res.enumerated() {
            for i in array {
                if i.driver.driverID == driver {
                    driver = i.driver.driverID
                    driverQuali = Int(i.grid) ?? 0
                } else {
                    teammate = i.driver.driverID
                    teammateQuali = Int(i.grid) ?? 0
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

            if items.isEmpty {
                items["qualification"] = [[driver : driverQuali, teammate: teammateQuali]]
                // print("If is empty: \(items)")
            } else {
                if var compare = items["qualification"].map ({ $0.map ({ $0.keys.contains(teammate) }) })  {


                    if compare.count > 1 {
                        compare.remove(at: 1)
                        // print(compare)
                    }

                    for (_, bool) in compare.enumerated() {
                        if bool {
                            items["qualification"]![0][driver]! += driverQuali
                            items["qualification"]![0][teammate]! += teammateQuali
                            // print("num true \(index): \(items)")
                        } else {
                            items["qualification"]?.append([driver : driverQuali, teammate: teammateQuali])
                            // print("num false \(index): \(items)")
                        }
                    }
                }
            }
        }
    }
}
