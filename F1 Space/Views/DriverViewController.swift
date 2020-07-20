//
//  DriversStandingViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class DriverViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var collectionView: UICollectionView!
//    var drivers: [DriverStandings]?
    
    var driverViewModel: DriverViewModel?
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.register(DriversCell.self, forCellWithReuseIdentifier: DriversCell.reusId)
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension DriverViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return drivers?.count ?? 0
        return driverViewModel?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DriversCell.reusId, for: indexPath) as! DriversCell
        
        let driverCellViewModel = driverViewModel?.cellForItemAt(indexPath: indexPath.item)
        cell.configureViewModel(cellViewModel: driverCellViewModel)
        
//        let driver = drivers?[indexPath.item]
//        cell.configure(driver: driver)
        
        return cell
    }
}

// MARK: - Extension CollectionViewDelegateFlowLayout

extension DriverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
}
