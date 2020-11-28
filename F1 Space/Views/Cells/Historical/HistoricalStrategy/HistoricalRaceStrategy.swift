//
//  HistoricalRaceStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalRaceStrategy: HistoricalStandingsStrategy {
    
    private(set) var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.textColor = .white
        }
        
        width[forThe.first]?.isActive = false
        width[forThe.second]?.isActive = true
        
        
        [labels[forThe.fourth] ,labels[forThe.fifth], labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
        
        width[forThe.second]?.constant = rootView.frame.width / 4
        
        width[forThe.third]?.constant = rootView.frame.width / 3.5
        width[forThe.third]?.isActive = true
    }
    
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text  = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text  = viewModel?.third
    }
    
    func configureHeader(viewModel: HistoricalHeaderViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text = viewModel?.third
    }
}
