//
//  HistoricalDriverDetailStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverDetailStrategy: HistoricalStandingsStrategyType {
    
    // MARK: - Properties

    private(set) var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    // MARK: - Methods
    
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView) {
        labels.forEach {
            $0.textAlignment = .center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        width[forThe.third]?.isActive = false
        labels[forThe.fourth].isHidden = false
        
        width[forThe.first]?.constant = rootView.frame.width / 3.5
        width[forThe.first]?.isActive = true
        
        width[forThe.second]?.constant = rootView.frame.width / 8
        width[forThe.second]?.isActive = true
        
        width[forThe.fourth]?.constant = rootView.frame.width / 8
        width[forThe.fourth]?.isActive = true
        
        [labels[forThe.fifth], labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
    }
    
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text  = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text  = viewModel?.third
        labels[forThe.fourth].text = viewModel?.fourth
    }
    
    func configureHeader(viewModel: HistoricalHeaderViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text = viewModel?.third
        labels[forThe.fourth].text = viewModel?.fourth
    }
}
