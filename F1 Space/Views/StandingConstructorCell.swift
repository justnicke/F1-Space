//
//  StandingConstructorCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 09.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingConstructorCell: UICollectionViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: StandingConstructorCell.self)
    
    let constructorViewController = ConstructorViewController()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(constructorViewController.view)
        constructorViewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(constructor: Standings?) {
        constructorViewController.constructor = constructor
        constructorViewController.collectionView.reloadData()
    }
}
