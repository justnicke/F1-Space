//
//  StandingsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class StandingsViewController: UIViewController {
    
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
        
        collectionView.register(StandingsCell.self, forCellWithReuseIdentifier: StandingsCell.reusId)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingsCell.reusId, for: indexPath) as! StandingsCell
        cell.backgroundColor = .black
        return cell
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
