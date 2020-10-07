//
//  DriverStrategy.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 24.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

struct ModelType {
    var driverStandings: DriverStandings?
    var constructorStandings: ConstructorStandings?
    
    init(driver: DriverStandings) {
        self.driverStandings = driver
    }
    init(constructor: ConstructorStandings) {
        self.constructorStandings = constructor
    }
}

struct ModelTypeHeader {
    var driverStandings: DriverHeader?
    var constructorStandings: TeamHeader?
    
    init(driver: DriverHeader) {
        self.driverStandings = driver
    }
    init(constructor: TeamHeader) {
        self.constructorStandings = constructor
    }
}

struct LabelEnum {
    var first   = 0
    var second  = 1
    var third   = 2
    var fourth  = 3
    var fifth   = 4
    var sixth   = 5
    
}

protocol StandingsStrategy: class {
    func setupUI(for labels: [UILabel], rootView: UIView, widthConst: [NSLayoutConstraint?])
    func configureCell(for labels: [UILabel], result: ModelType)
    func configureHeader(for labels: [UILabel], rootView: UIView, model: ModelTypeHeader)
}

final class DriverStrategy: StandingsStrategy {

    var num = LabelEnum(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    func setupUI(for labels: [UILabel], rootView: UIView, widthConst: [NSLayoutConstraint?]) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        widthConst[num.third]?.isActive = false
        labels[num.fourth].isHidden = false
        
        widthConst[num.first]?.constant = rootView.frame.width / 6
        widthConst[num.first]?.isActive = true
        
        widthConst[num.second]?.constant = rootView.frame.width / 4
        widthConst[num.second]?.isActive = true
        
        widthConst[num.fourth]?.constant = rootView.frame.width / 6
        widthConst[num.fourth]?.isActive = true
        
        [labels[num.fifth], labels[num.sixth]].forEach {
            $0.isHidden = true
        }
    }
    
    func configureCell(for labels: [UILabel], result: ModelType) {
        labels[num.first].text = result.driverStandings?.position
        labels[num.second].text = result.driverStandings?.driver.familyName
        labels[num.third].text = result.driverStandings?.team.first?.name
        labels[num.fourth].text = result.driverStandings?.points
    }
    
    func configureHeader(for labels: [UILabel], rootView: UIView, model: ModelTypeHeader) {
        labels[num.first].text = model.driverStandings?.position
        labels[num.second].text = model.driverStandings?.driverName
        labels[num.third].text = model.driverStandings?.team
        labels[num.fourth].text = model.driverStandings?.points
    }
}

final class ConstructorStrategy: StandingsStrategy {
        
    var num = LabelEnum(first: 0, second: 1, third: 2, fourth: 3, fifth: 4, sixth: 5)
    
    func setupUI(for labels: [UILabel], rootView: UIView, widthConst: [NSLayoutConstraint?]) {
        labels.forEach {
            $0.textAlignment = . center
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        widthConst[num.second]?.isActive = false

        [labels[num.fourth] ,labels[num.fifth], labels[num.sixth]].forEach {
            $0.isHidden = true
        }
        
        widthConst[num.first]?.constant = rootView.frame.width / 6
        widthConst[num.first]?.isActive = true
        
        widthConst[num.third]?.constant = rootView.frame.width / 6
        widthConst[num.third]?.isActive = true
    }
    
    func configureCell(for labels: [UILabel], result: ModelType) {
        labels[num.first].text = result.constructorStandings?.position
        labels[num.second].text = result.constructorStandings?.constructor.name
        labels[num.third].text = result.constructorStandings?.points
    }
    
    func configureHeader(for labels: [UILabel], rootView: UIView, model: ModelTypeHeader) {
        labels[num.first].text = model.constructorStandings?.position
        labels[num.second].text = model.constructorStandings?.constructorName
        labels[num.third].text = model.constructorStandings?.points
    }
}

