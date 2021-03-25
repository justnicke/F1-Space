//
//  HistoricalCurrentDriverViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalCurrentDriverViewController: BaseHistoricalDetailViewController<HistoricalCurrentDriverViewModel> {

    // MARK: - Public Properties
    
    var driver: String
    var season: String
    
    var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    

    // MARK: - Constructors
    
    override init(viewModel: HistoricalCurrentDriverViewModel?) {
        self.driver = viewModel?.driverStandings.driver.driverID ?? ""
        self.season = viewModel?.season ?? "2021"
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        requestData()
        setupCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func requestData() {
        self.viewModel?.reload()
        DispatchQueue.main.async {
            self.viewModel?.closure = { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBlue
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.register(DuelCollectionViewCell.self, forCellWithReuseIdentifier: DuelCollectionViewCell.reuseId)
    }
}

// MARK: - Extension UICollectionViewDataSource & UICollectionViewDelegate

extension HistoricalCurrentDriverViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuelCollectionViewCell.reuseId, for: indexPath) as! DuelCollectionViewCell
        
        guard let cellViewModel = viewModel?.cellForRowAt(indexPath: indexPath) else { return DuelCollectionViewCell() }
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
}

extension HistoricalCurrentDriverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
}
