//
//  HistoricalConstructorDetailStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 27.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalConstructorDetailStrategy: HistoricalStandingsStrategyType {
    
    // MARK: - Properties

    private(set) var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    // MARK: - Methods
    
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 11)
            $0.numberOfLines = 2
        }
        
        //  общие перед
        width[forThe.second]?.isActive = false
        labels[forThe.fourth].isHidden = false
        labels[forThe.fifth].isHidden = false
        
        // 1
        width[forThe.first]?.isActive = true
        width[forThe.first]?.constant = rootView.frame.width / 5

        // 3
        width[forThe.third]?.constant = rootView.frame.width / 8
        width[forThe.third]?.isActive = true

        // 4
        width[forThe.fourth]?.constant = rootView.frame.width / 3.7
        width[forThe.fourth]?.isActive = true
        
        // 5
        width[forThe.fifth]?.constant = rootView.frame.width / 8
        width[forThe.fifth]?.isActive = true
        
        [labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
    }
    
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel]) {
        labels[forThe.first].text  = viewModel?.first
        labels[forThe.second].text = viewModel?.second
        labels[forThe.third].text  = viewModel?.third
        labels[forThe.fourth].text = viewModel?.fourth
        labels[forThe.fifth].text = viewModel?.fifth
    }
    
    func configureHeader(viewModel: HistoricalHeaderViewModel?, for labels: [UILabel]) {
//        labels[forThe.first].text = viewModel?.first
//        labels[forThe.second].text = viewModel?.second
//        labels[forThe.third].text = viewModel?.third
//        labels[forThe.fourth].text = viewModel?.fourth
//        labels[forThe.fifth].text = viewModel?.fifth
    }
}
