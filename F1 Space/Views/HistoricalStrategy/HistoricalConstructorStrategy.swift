//
//  HistoricalConstructorStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalConstructorStrategy: HistoricalStandingsStrategyType {
    
    var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    func setupUI(for labels: [UILabel], from rootView: UIView, by widthConst: [NSLayoutConstraint?]) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        widthConst[forThe.second]?.isActive = false
        
        [labels[forThe.fourth] ,labels[forThe.fifth], labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
        
        widthConst[forThe.first]?.constant = rootView.frame.width / 6
        widthConst[forThe.first]?.isActive = true
        
        widthConst[forThe.third]?.constant = rootView.frame.width / 6
        widthConst[forThe.third]?.isActive = true
    }
    
    func configureCell(for labels: [UILabel], on model: HistoricalStandings) {
        labels[forThe.first].text = model.constructorStandings?.position
        labels[forThe.second].text = model.constructorStandings?.constructor.name
        labels[forThe.third].text = model.constructorStandings?.points
    }
    
    func configureHeader(for labels: [UILabel], from rootView: UIView, by model: HistoricalStandingsHeader) {
        labels[forThe.first].text = model.firstHead
        labels[forThe.second].text = model.secondHead
        labels[forThe.third].text = model.thirdHead
    }
}
