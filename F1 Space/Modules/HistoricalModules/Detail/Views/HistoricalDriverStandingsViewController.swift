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
                    
                    let trueOrFalse = res.compactMap ({ $0.driver.driverID.contains(driver) })
                    
                    if trueOrFalse.contains(true) {
                        self?.numOfRace += 1
                        self?.arrays.append(res)
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            print(self.arrays.map{$0.map{$0.driver.driverID}})
            print(self.numOfRace)
        }
    }
    
    var numOfRace = 0
    
    // name
    var driver: String
    var teammate = ""

    // quali
    var driverQuali = 0
    var teammateQuali = 0
    
//    func testDict(res: [[ResultF1]]) {
//        for (_, array) in res.enumerated() {
//            for i in array {
//                if i.driver.name == "bottas" {
//                    driver = i.driver.name
//                    driverQuali = i.position
//                } else {
//                    teammate = i.driver.name
//                    teammateQuali = i.position
//                }
//            }
//
//            if driverQuali < teammateQuali {
//                driverQuali = 0
//                teammateQuali = 0
//                driverQuali += 1
//            } else {
//                teammateQuali = 0
//                driverQuali = 0
//                teammateQuali += 1
//            }
//
//            if items.isEmpty {
//                items["qualification"] = [[driver : driverQuali, teammate: teammateQuali]]
//                // print("If is empty: \(items)")
//            } else {
//                if var compare = items["qualification"].map ({ $0.map ({ $0.keys.contains(teammate) }) })  {
//
//
//                    if compare.count > 1 {
//                        compare.remove(at: 1)
//                        // print(compare)
//                    }
//
//                    for (index, bool) in compare.enumerated() {
//                        if bool {
//                            items["qualification"]![0][driver]! += driverQuali
//                            items["qualification"]![0][teammate]! += teammateQuali
//                            // print("num true \(index): \(items)")
//                        } else {
//                            items["qualification"]?.append([driver : driverQuali, teammate: teammateQuali])
//                            // print("num false \(index): \(items)")
//                        }
//                    }
//                }
//            }
//        }
//    }
}
