//
//  StandingsCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingDriverCell: UICollectionViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: StandingDriverCell.self)
    
    // MARK: Private Properties
    
    let driversViewController = DriverViewController()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        addSubview(driversViewController.view)
        driversViewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(driver: [DriverStandings]?) {
        driversViewController.drivers = driver
        driversViewController.collectionView.reloadData()
    }
}
