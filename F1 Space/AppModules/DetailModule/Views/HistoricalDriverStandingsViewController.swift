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
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello \(self)")
        view.backgroundColor = .red
        
        viewModel = HistoricalDriverStandingsViewModel()
    }
}
