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
    
    var collectionView: UICollectionView!
    
    let segmentView: UIView = {
           let view = UIView()
           view.heightAnchor.constraint(equalToConstant: 70).isActive = true
           return view
    }()
    let segmentChoiceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let driversButton: UIButton = {
        let button = UIButton()
        button.setTitle("Drivers", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        return button
    }()
    let constructorsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Constructors", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return button
    }()
    
    lazy var leadingConstant = segmentChoiceView.leadingAnchor.constraint(equalTo: segmentView.leadingAnchor, constant: 0)
    lazy var trailingConstant = segmentChoiceView.trailingAnchor.constraint(equalTo: segmentView.trailingAnchor, constant: -view.frame.width / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
        
        setupLayoutAndLogicSegmentView()
        
        driversButton.addTarget(self, action: #selector(driverButtonAction(_:)), for: .touchUpInside)
        constructorsButton.addTarget(self, action: #selector(constructorButtonAction(_:)), for: .touchUpInside)
        
    }

    private func setupCollectionView() {
        view.addSubview(segmentView)
        segmentView.backgroundColor = .red
        
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
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
    
    private func setupLayoutAndLogicSegmentView() {
        let stackView = UIStackView(arrangedSubviews: [driversButton, constructorsButton], axis: .horizontal)
        stackView.distribution = .fillEqually
        
        segmentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: segmentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: segmentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: segmentView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: segmentView.heightAnchor, multiplier: 0.9).isActive = true
        
        segmentView.addSubview(segmentChoiceView)
        
        segmentChoiceView.translatesAutoresizingMaskIntoConstraints = false
        segmentChoiceView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
        segmentChoiceView.bottomAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 0).isActive = true
        leadingConstant.isActive = true
        trailingConstant.isActive = true

    }
    
    @objc func driverButtonAction(_ sender: UIButton) {
        let nextItem = NSIndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
        
        driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        
        leadingConstant.constant = 0
        trailingConstant.constant = -view.frame.width / 2
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func constructorButtonAction(_ sender: UIButton) {
        let nextItem = NSIndexPath(row: 1, section: 0)
        self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
        
        
        constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)

        leadingConstant.constant = view.frame.width / 2
        trailingConstant.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect: CGRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.collectionView?.indexPathForItem(at: visiblePoint)
        if visibleIndexPath?.item == 0 {
            driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
            constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
            leadingConstant.constant = 0
            trailingConstant.constant = -view.frame.width / 2
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
            driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
            
            leadingConstant.constant = view.frame.width / 2
            trailingConstant.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
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

final class BetterSnappingLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return
                super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                          withScrollingVelocity: velocity)
        }
        
        let nextX: CGFloat
        
        if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset {
            nextX = proposedContentOffset.x
        } else {
            nextX = collectionView.contentOffset.x + (velocity.x > 0 ? collectionView.bounds.size.width : -collectionView.bounds.size.width)
        }
        
        let targetRect = CGRect(x: nextX,
                                y: 0,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        layoutAttributesArray?.forEach( { (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
