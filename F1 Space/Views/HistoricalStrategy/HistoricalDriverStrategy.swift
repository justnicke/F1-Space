//
//  HistoricalDriverStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 24.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalDriverStrategy: HistoricalStandingsStrategyType {

    var forThe = AuxiliaryNumbering(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    func setupUI(for labels: [UILabel], from rootView: UIView, by widthConst: [NSLayoutConstraint?]) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        widthConst[forThe.third]?.isActive = false
        labels[forThe.fourth].isHidden = false
        
        widthConst[forThe.first]?.constant = rootView.frame.width / 6
        widthConst[forThe.first]?.isActive = true
        
        widthConst[forThe.second]?.constant = rootView.frame.width / 4
        widthConst[forThe.second]?.isActive = true
        
        widthConst[forThe.fourth]?.constant = rootView.frame.width / 6
        widthConst[forThe.fourth]?.isActive = true
        
        [labels[forThe.fifth], labels[forThe.sixth]].forEach {
            $0.isHidden = true
        }
    }
    
    func configureCell(for labels: [UILabel], on model: HistoricalStandings) {
        labels[forThe.first].text  = model.driverStandings?.position
        labels[forThe.second].text = model.driverStandings?.driver.familyName
        labels[forThe.third].text  = model.driverStandings?.team.first?.name
        labels[forThe.fourth].text = model.driverStandings?.points
    }
    
    func configureHeader(for labels: [UILabel], from rootView: UIView, by model: HistoricalStandingsHeader) {
        labels[forThe.first].text = model.firstHead
        labels[forThe.second].text = model.secondHead
        labels[forThe.third].text = model.thirdHead
        labels[forThe.fourth].text = model.fourthHead

    }
}



