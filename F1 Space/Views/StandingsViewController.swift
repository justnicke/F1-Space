//
//  StandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var standings = StandingsTest(
        drivers: [
            Drivers(firstName: "Valtteri", lastName: "BOTTAS", position: "1", pts: "25", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
            Drivers(firstName: "Charles", lastName: "LECLERC", position: "2", pts: "18", team: "Ferrari", teamColor: #colorLiteral(red: 0.8402977586, green: 0.02978832088, blue: 0.01825268567, alpha: 1)),
            Drivers(firstName: "Lando", lastName: "NORRIS", position: "3", pts: "16", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
            Drivers(firstName: "Lewis", lastName: "HAMILTON", position: "4", pts: "12", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
            Drivers(firstName: "Carlos", lastName: "SAINZ", position: "5", pts: "10", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
            Drivers(firstName: "Sergio", lastName: "PEREZ", position: "6", pts: "8", team: "Racing Point", teamColor: #colorLiteral(red: 0.9427306056, green: 0.5931260586, blue: 0.78516078, alpha: 1)),
            Drivers(firstName: "Pierre", lastName: "GASLY", position: "7", pts: "6", team: "AlphaTauri", teamColor: #colorLiteral(red: 0.9872925878, green: 0.9923736453, blue: 0.9921157956, alpha: 1)),
            Drivers(firstName: "Esteban", lastName: "OKON", position: "8", pts: "4", team: "Renault", teamColor: #colorLiteral(red: 0.9814451337, green: 0.9618824124, blue: 0.02284554951, alpha: 1))],
        constructors: [
            Constructorz(position: "1", pts: "25", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1)),
            Constructorz(position: "2", pts: "18", team: "Ferrari", teamColor: #colorLiteral(red: 0.8402977586, green: 0.02978832088, blue: 0.01825268567, alpha: 1)),
            Constructorz(position: "3", pts: "16", team: "McLaren", teamColor: #colorLiteral(red: 0.978580296, green: 0.5295285583, blue: 0.006929721218, alpha: 1)),
            Constructorz(position: "4", pts: "12", team: "Mercedes", teamColor: #colorLiteral(red: 0, green: 0.8169876933, blue: 0.7409536242, alpha: 1))]
    )
    
    var drivers: [Driver]?
    
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let segmentedView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return view
    }()
    private let lineSelectedSegmentedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let driversButton: UIButton = {
        let button = UIButton()
        button.setTitle("Drivers", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        return button
    }()
    private let constructorsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Constructors", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return button
    }()
    private var snapToMostVisibleColumnVelocityThreshold: CGFloat {
        return 0.3
    }
    lazy private var leadingConstant = lineSelectedSegmentedView.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor, constant: 0)
    lazy private var trailingConstant = lineSelectedSegmentedView.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor, constant: -view.frame.width / 2)
    
    // MARK: - Public Nested
    
    private enum ButtonState {
        case drivers
        case constructors
    }

    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupLayoutSegmentedView()
        
        driversButton.addTarget(self, action: #selector(driverButtonAction(_:)), for: .touchUpInside)
        constructorsButton.addTarget(self, action: #selector(constructorButtonAction(_:)), for: .touchUpInside)
        
        API.requestDriverStandings { [weak self] (driversPeople, err) in
            let convert = driversPeople?.mrData.standingsTable.standingsLists.compactMap {$0.driverStandings.compactMap{$0.driver}}
            let test = convert?.reduce([], +)
            self?.drivers = test
            self?.collectionView.reloadData()
        }
    }

    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        
        collectionView.register(StandingDriverCell.self, forCellWithReuseIdentifier: StandingDriverCell.reusId)
        collectionView.register(StandingConstructorCell.self, forCellWithReuseIdentifier: StandingConstructorCell.reusId)
        
        let mainStackView = UIStackView(arrangedSubviews: [segmentedView, collectionView], axis: .vertical)
        view.addSubview(mainStackView)

        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .zero)
    }
    
    private func setupLayoutSegmentedView() {
        let buttonStackView = UIStackView(arrangedSubviews: [driversButton, constructorsButton], axis: .horizontal, distribution: .fillEqually)
        
        [buttonStackView, lineSelectedSegmentedView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        buttonStackView.topAnchor.constraint(equalTo: segmentedView.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor).isActive = true
        buttonStackView.heightAnchor.constraint(equalTo: segmentedView.heightAnchor, multiplier: 0.9).isActive = true
                
        lineSelectedSegmentedView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor).isActive = true
        lineSelectedSegmentedView.bottomAnchor.constraint(equalTo: segmentedView.bottomAnchor).isActive = true
        leadingConstant.isActive = true
        trailingConstant.isActive = true
    }
    
    private func visibleCell(row: Int, section: Int) {
        let nextItem = NSIndexPath(row: row, section: section)
        self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func selectedSegment(state: ButtonState) {
        switch state {
        case .drivers:
            driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
            constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
            
            leadingConstant.constant = 0
            trailingConstant.constant = -view.frame.width / 2
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        case .constructors:
            constructorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
            driversButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
            
            leadingConstant.constant = view.frame.width / 2
            trailingConstant.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func driverButtonAction(_ sender: UIButton) {
        visibleCell(row: 0, section: 0)
        selectedSegment(state: .drivers)
    }
    
    @objc private func constructorButtonAction(_ sender: UIButton) {
        visibleCell(row: 1, section: 0)
        selectedSegment(state: .constructors)
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
            constructorCell.configure(constructor: standings)
            return constructorCell
        }
    }
}

// MARK: - Extension CollectionViewDelegateFlowLayout

extension StandingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - Extension ScrollViewDelegate

extension StandingsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect: CGRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.collectionView?.indexPathForItem(at: visiblePoint)
        if visibleIndexPath?.item == 0 {
            selectedSegment(state: .drivers)
        } else {
            selectedSegment(state: .constructors)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionViewLayout
        let bounds = scrollView.bounds
        let xTarget = targetContentOffset.pointee.x
        let xMax = scrollView.contentSize.width - scrollView.bounds.width
        
        if abs(velocity.x) <= snapToMostVisibleColumnVelocityThreshold {
            let xCenter = scrollView.bounds.midX
            let poses = layout.layoutAttributesForElements(in: bounds) ?? []
            let x = poses.min(by: { abs($0.center.x - xCenter) < abs($1.center.x - xCenter) })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = x
        } else if velocity.x > 0 {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            let xCurrent = scrollView.contentOffset.x
            let x = poses.filter({ $0.frame.origin.x > xCurrent}).min(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? xMax
            targetContentOffset.pointee.x = min(x, xMax)
        } else {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget - bounds.size.width,
                                                                      y: 0,
                                                                      width: bounds.size.width,
                                                                      height: bounds.size.height)) ?? []
            let x = poses.max(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = max(x, 0)
        }
    }
}
