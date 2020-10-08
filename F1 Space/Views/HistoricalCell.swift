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
    
    var historicalStandingsStrategy: HistoricalStandingsStrategyType?
    
    // MARK: - Private Properties
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let fouthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let fifthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let sixthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    
    private lazy var firstWidth = firstLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var secondWidth = secondLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var thirdWidth = thirdLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var fourthWidth = fouthLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var fifthWidth = fifthLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var sixthWidth = sixthLabel.widthAnchor.constraint(equalToConstant: 0)
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(driver: DriverStandings, rootView: UIView) {
        historicalStandingsStrategy = HistoricalDriverStrategy()
        historicalStandingsStrategy?.setupUI(
            for: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            from: rootView,
            by: [firstWidth, secondWidth, thirdWidth, fourthWidth, fifthWidth, sixthWidth]
        )
        
        historicalStandingsStrategy?.configureCell(
            for: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            on: HistoricalStandings(driver)
        )
        
    }
    
    func configure(team: ConstructorStandings, rootView: UIView) {
        historicalStandingsStrategy = HistoricalConstructorStrategy()
        historicalStandingsStrategy?.setupUI(
            for: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            from: rootView,
            by: [firstWidth, secondWidth, thirdWidth, fourthWidth, fifthWidth, sixthWidth]
        )
        
        historicalStandingsStrategy?.configureCell(
            for: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            on: HistoricalStandings(team)
        )
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel].forEach {
            $0.textAlignment = . center
            $0.backgroundColor = .white
            $0.font = UIFont(name: "AvenirNext-Medium", size: 13)
        }
        
        let stackView = UIStackView(
            arrangedSubviews: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            axis: .horizontal,
            spacing: 0
        )
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)

        firstLabel.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        secondLabel.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        thirdLabel.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        fouthLabel.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        fifthLabel.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        sixthLabel.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
}
