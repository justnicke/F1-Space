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
    
    // MARK: Private Properties
    
    private let constructorViewController = ConstructorViewController()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(constructorViewController.view)
        constructorViewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func confugureViewModel(viewModel: StandingsCellViewModel?) {
        constructorViewController.constructorViewModel = viewModel?.constructorViewModel
        constructorViewController.collectionView.reloadData()
    }
    
//    func configure(constructor: [ConstructorStandings]?) {
//        constructorViewController.constructors = constructor
//        constructorViewController.collectionView.reloadData()
//    }
}
