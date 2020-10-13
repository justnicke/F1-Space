//
//  HistoricalConstructorStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalConstructorStrategy: HistoricalStandingsStrategyType {
    
    // MARK: - Properties
    
    private(set) var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    // MARK: - Methods
    
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        width[forThe.second]?.isActive = false
        
        [labels[forThe.fourth] ,labels[forThe.fifth], labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
        
        width[forThe.first]?.constant = rootView.frame.width / 6
        width[forThe.first]?.isActive = true
        
        width[forThe.third]?.constant = rootView.frame.width / 6
        width[forThe.third]?.isActive = true
    }
    
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text  = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text  = viewModel?.third
    }
    
    func configureHeader(for labels: [UILabel], by model: HistoricalStandingsHeader) {
        labels[forThe.first].text = model.firstHead
        labels[forThe.second].text = model.secondHead
        labels[forThe.third].text = model.thirdHead
    }
}
