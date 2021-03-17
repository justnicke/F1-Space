//
//  HistoricalDriverDetailViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverDetailViewController: BaseHistoricalDetailViewController<HistoricalDriverDetailViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello \(self)")
        view.backgroundColor = .black

    }
}
