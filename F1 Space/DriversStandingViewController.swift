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
        Driver(firstName: "Valtteri", lastName: "BOTTAS", position: "1", pts: "25", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
        Driver(firstName: "Charles", lastName: "LECLERC", position: "2", pts: "18", team: "Ferrari", teamColor: #colorLiteral(red: 0.8402977586, green: 0.02978832088, blue: 0.01825268567, alpha: 1)),
        Driver(firstName: "Lando", lastName: "NORRIS", position: "3", pts: "16", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
        Driver(firstName: "Lewis", lastName: "HAMILTON", position: "4", pts: "12", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
        Driver(firstName: "Carlos", lastName: "SAINZ", position: "5", pts: "10", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
        Driver(firstName: "Sergio", lastName: "PEREZ", position: "6", pts: "8", team: "Racing Point", teamColor: #colorLiteral(red: 0.9427306056, green: 0.5931260586, blue: 0.78516078, alpha: 1)),
        Driver(firstName: "Pierre", lastName: "GASLY", position: "7", pts: "6", team: "AlphaTauri", teamColor: #colorLiteral(red: 0.9872925878, green: 0.9923736453, blue: 0.9921157956, alpha: 1)),
        Driver(firstName: "Esteban", lastName: "OKON", position: "8", pts: "4", team: "Renault", teamColor: #colorLiteral(red: 0.9814451337, green: 0.9618824124, blue: 0.02284554951, alpha: 1))]
    
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
