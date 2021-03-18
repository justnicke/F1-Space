//
//  HistoricalDriverStandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverStandingsViewController: BaseHistoricalDetailViewController<HistoricalDriverStandingsViewModel> {
    
    var items: [String : [[String : Int]]] = [:]
    var res = [[ResultF1]]()
    var names = ["hamilton", "russel"]
    
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
    
    let semaphore = DispatchSemaphore(value: 0)
    
    var collectionView: UICollectionView!
    
    override init(viewModel: HistoricalDriverStandingsViewModel?) {
        self.driver = viewModel?.driverID ?? ""
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCollectionView()
        
        testFunc()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBlue
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.register(DuelCollectionViewCell.self, forCellWithReuseIdentifier: DuelCollectionViewCell.reuseId)
    }

    
    
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
//            print(self.items)
        }
    }

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
    
    func getTeammates(indexPath: IndexPath) -> [String] {
        guard var teammates = items["qualification"]?[indexPath.item].map ({ String($0.key) }) else {
            return []
        }
        
        for (i, e) in teammates.enumerated() {
            if e == driver {
                teammates.remove(at: i)
            }
        }
        
        return teammates
    }
}

// MARK: - Extension UICollectionViewDataSource & UICollectionViewDelegate

extension HistoricalDriverStandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items["qualification"]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuelCollectionViewCell.reuseId, for: indexPath) as! DuelCollectionViewCell
        
//        var aaa = items["qualification"]?[indexPath.item].map { String($0.key) }


        cell.driverNameLabel.text = driver.capitalized
        cell.teammateNameLabel.text = getTeammates(indexPath: indexPath).first
        
  
        cell.driverQualiScoreLabel.text = String(items["qualification"]?[indexPath.item][driver] ?? 0)
        cell.teammateQualiScoreLabel.text = String(items["qualification"]?[indexPath.item][getTeammates(indexPath: indexPath).first ?? ""] ?? 0)
        

    
        
  
        
//        cell.driverQualiScoreLabel =
        
        
        
        
        return cell
    }
}

extension HistoricalDriverStandingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
}
