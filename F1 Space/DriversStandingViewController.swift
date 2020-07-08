//
//  DriversStandingViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class DriversStandingViewController: UIViewController {
    
    var collectionView: UICollectionView!

    var drivers = [
        Driver(firstName: nil, lastName: nil, position: "1", pts: nil, team: nil, teamColor: nil),
        Driver(firstName: nil, lastName: nil, position: "2", pts: nil, team: nil, teamColor: nil),
        Driver(firstName: nil, lastName: nil, position: "3", pts: nil, team: nil, teamColor: nil),
        Driver(firstName: nil, lastName: nil, position: "4", pts: nil, team: nil, teamColor: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
                
        setupCollectionView()
    }
    
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

extension DriversStandingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DriversCell.reusId, for: indexPath) as! DriversCell
        
        let driver = drivers[indexPath.item]
        cell.configure(driver: driver)
        
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension DriversStandingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
    
}
