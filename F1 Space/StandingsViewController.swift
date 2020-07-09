//
//  StandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingsViewController: UIViewController {
    
    var drivers = Standings(drivers: [
        Driver(firstName: "Valtteri", lastName: "BOTTAS", position: "1", pts: "25", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
        Driver(firstName: "Charles", lastName: "LECLERC", position: "2", pts: "18", team: "Ferrari", teamColor: #colorLiteral(red: 0.8402977586, green: 0.02978832088, blue: 0.01825268567, alpha: 1)),
        Driver(firstName: "Lando", lastName: "NORRIS", position: "3", pts: "16", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
        Driver(firstName: "Lewis", lastName: "HAMILTON", position: "4", pts: "12", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
        Driver(firstName: "Carlos", lastName: "SAINZ", position: "5", pts: "10", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
        Driver(firstName: "Sergio", lastName: "PEREZ", position: "6", pts: "8", team: "Racing Point", teamColor: #colorLiteral(red: 0.9427306056, green: 0.5931260586, blue: 0.78516078, alpha: 1)),
        Driver(firstName: "Pierre", lastName: "GASLY", position: "7", pts: "6", team: "AlphaTauri", teamColor: #colorLiteral(red: 0.9872925878, green: 0.9923736453, blue: 0.9921157956, alpha: 1)),
        Driver(firstName: "Esteban", lastName: "OKON", position: "8", pts: "4", team: "Renault", teamColor: #colorLiteral(red: 0.9814451337, green: 0.9618824124, blue: 0.02284554951, alpha: 1))],
                            constructors: [
        Constructor(position: "1", pts: "25", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
        Constructor(position: "2", pts: "18", team: "Ferrari", teamColor: #colorLiteral(red: 0.8402977586, green: 0.02978832088, blue: 0.01825268567, alpha: 1)),
        Constructor(position: "3", pts: "16", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
        Constructor(position: "4", pts: "12", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1))])
    
    let segmentView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return view
    }()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        

        setupCollectionView()
    
    }

    private func setupCollectionView() {
        view.addSubview(segmentView)
        segmentView.backgroundColor = .red
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.register(StandingDriverCell.self, forCellWithReuseIdentifier: StandingDriverCell.reusId)
        collectionView.register(StandingConstructorCell.self, forCellWithReuseIdentifier: StandingConstructorCell.reusId)
        
        let stackView = UIStackView(arrangedSubviews: [segmentView, collectionView])
        stackView.axis = .vertical
        view.addSubview(stackView)

        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .zero)
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let drivingCell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingDriverCell.reusId, for: indexPath) as! StandingDriverCell
            
            drivingCell.configure(driver: drivers)
            return drivingCell
        } else {
            let constructorCell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingConstructorCell.reusId, for: indexPath) as! StandingConstructorCell
            constructorCell.configure(constructor: drivers)
            return constructorCell
        }
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension StandingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}
