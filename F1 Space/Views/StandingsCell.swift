//
//  StandingsCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingsCell: UICollectionViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: StandingsCell.self)
    
    let driversStandingViewController = DriversStandingViewController()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        addSubview(driversStandingViewController.view)
        driversStandingViewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
