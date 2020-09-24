//
//  HistoricalCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 24.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: HistoricalCell.self)
    
    
    // MARK: - Private Properties
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any3Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any4Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any5Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
//        setupUITeam()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(driver: DriverStandings) {
        positionLabel.text = driver.position
        any1Label.text = driver.driver.familyName
        any2Label.text = driver.team.first?.name
        any3Label.text = driver.points
        
        any3Label.isHidden = false
  
    }
    
    func configureTeam(team: ConstructorStandings) {
        positionLabel.text = team.position
        any1Label.text = team.constructor.name
        any2Label.text = team.points
        
        any3Label.isHidden = true
//        setupUITeam()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        [positionLabel, any1Label, any2Label, any3Label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
            $0.textAlignment = . center
            $0.backgroundColor = .black
        }
        
        positionLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        positionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        positionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        positionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        any1Label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        any1Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        any1Label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        any1Label.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor).isActive = true
        any1Label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        any2Label.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        any2Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        any2Label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        any2Label.leadingAnchor.constraint(equalTo: any1Label.trailingAnchor).isActive = true
        any2Label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        any3Label.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        any3Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        any3Label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        any3Label.leadingAnchor.constraint(equalTo: any2Label.trailingAnchor).isActive = true
        any3Label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupUITeam() {
        [positionLabel, any1Label, any2Label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
            $0.textAlignment = . center
            $0.backgroundColor = .black
        }
        layoutIfNeeded()
        positionLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        positionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        positionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        positionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        any1Label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        any1Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        any1Label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        any1Label.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor).isActive = true
        any1Label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50).isActive = true
        
        any2Label.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        any2Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        any2Label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        any2Label.leadingAnchor.constraint(equalTo: any1Label.trailingAnchor).isActive = true
        any2Label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        any2Label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35).isActive = true
        
    }
}
