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

protocol StandingsStrategy: class {
    func setupUI(for labels: [UILabel?], cell: UITableViewCell, widthConst: [NSLayoutConstraint?])
    func configureCell(for labels: [UILabel?], result: ModelType)
//    var widthCon: [NSLayoutConstraint?] { get set }
}


final class DriverStrategy: StandingsStrategy {
    
//    var widthCon: [NSLayoutConstraint?] = []
    
    func setupUI(for labels: [UILabel?], cell: UITableViewCell, widthConst: [NSLayoutConstraint?]) {
//        widthCon = widthConst
        
        labels.forEach {
//            $0 = UILabel
            $0?.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview($0 ?? UIView())
            $0?.textAlignment = . center
            $0?.backgroundColor = .black
            $0?.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        widthConst.forEach {
            $0?.isActive = true
        }

        labels[0]?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        labels[0]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[0]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[0]?.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
//        labels[0]?.widthAnchor.constraint(equalToConstant: cell.frame.width / 4).isActive = true
        widthConst[0]?.constant = cell.frame.width / 4
        
        labels[1]?.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        labels[1]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[1]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[1]?.leadingAnchor.constraint(equalTo: labels[0]!.trailingAnchor).isActive = true
        labels[1]?.widthAnchor.constraint(equalToConstant: cell.frame.width / 4).isActive = true

        labels[2]?.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        labels[2]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[2]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[2]?.leadingAnchor.constraint(equalTo: labels[1]!.trailingAnchor).isActive = true
        // this is labels[2]
//        widthConst[0]?.isActive = true
        widthConst[1]?.constant = cell.frame.width / 4
//        widthCon?.isActive = true
//        widthCon?.constant = cell.frame.width / 4

        labels[3]?.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        labels[3]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[3]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[3]?.leadingAnchor.constraint(equalTo: labels[2]!.trailingAnchor).isActive = true
        labels[3]?.widthAnchor.constraint(equalToConstant: cell.frame.width / 4).isActive = true
    }
    
    func configureCell(for labels: [UILabel?], result: ModelType) {
        labels[0]?.text = result.driverStandings?.position
        labels[1]?.text = result.driverStandings?.driver.familyName
        labels[2]?.text = result.driverStandings?.team.first?.name
        labels[3]?.text = result.driverStandings?.points
    }
}
// Вынести констреинты и менять значения (попробываа

final class ConstructorStrategy: StandingsStrategy {

//    var widthCon: [NSLayoutConstraint?] = []
    
    func setupUI(for labels: [UILabel?], cell: UITableViewCell, widthConst: [NSLayoutConstraint?]) {
        
//        widthCon = widthConst
        
        labels.forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview($0 ?? UIView())
            $0?.textAlignment = . center
            $0?.backgroundColor = .black
        }
        
        widthConst.forEach {
            $0?.isActive = true
        }
        
        labels[0]?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        labels[0]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[0]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[0]?.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
//        labels[0]?.widthAnchor.constraint(equalToConstant: cell.frame.width / 4).isActive = true
        widthConst[0]?.constant = cell.frame.width / 6
        
        labels[1]?.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        labels[1]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[1]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[1]?.leadingAnchor.constraint(equalTo: labels[0]!.trailingAnchor).isActive = true
        labels[1]?.widthAnchor.constraint(equalToConstant: cell.frame.width / 4).isActive = true
        
        labels[2]?.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        labels[2]?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        labels[2]?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labels[2]?.leadingAnchor.constraint(equalTo: labels[1]!.trailingAnchor).isActive = true
        // this is labels[2]
        widthConst[1]?.constant = cell.frame.width / 2
//        widthConst[1]?.priority = UILayoutPriority(rawValue: 750)

    }

    func configureCell(for labels: [UILabel?], result: ModelType) {
        labels[0]?.text = result.constructorStandings?.position
        labels[1]?.text = result.constructorStandings?.constructor.name
        labels[2]?.text = result.constructorStandings?.points
    }
}

