//
//  HistoricalDriverStandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverStandingsViewController: UIViewController {
    
//    var viewModel: HistoricalDriverStandingsViewModel?
//
//    init(viewModel: HistoricalDriverStandingsViewModel?) {
//        self.viewModel = viewModel
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
  
    var bottasDuel = ["hamilton": ["qualification": 5, "race": 4], "russel": ["qualification": 1, "race": 1]]
    var teammates  = ["hamilton": ["qualification": 11, "race": 12], "russel": ["qualification": 0, "race": 0]]
    
    let duelView = DuelView()
    let duelView2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        
        view.addSubview(duelView)
        duelView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                        padding: .init(top: 200, left: 20, bottom: 0, right: 20),
                        size: .init(width: 0, height: 120))
        
//        viewModel = HistoricalDriverStandingsViewModel()
        
        //                Хэмилтон - Боттас
        //                  Квалификация
        //                       11—5
        //                      Гонка
        //                       12—4
        
        
        
        
        
    }
}
