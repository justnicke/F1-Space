//
//  HistoricalHeader.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 07.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalHeaderView: UIView {
    
    // MARK: - Private Properties
    
    private var historicalStandingsStrategy: HistoricalStandingsStrategyType?
    
    private let firstLabel  = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel  = UILabel()
    private let fouthLabel  = UILabel()
    private let fifthLabel  = UILabel()
    private let sixthLabel  = UILabel()
        
    private lazy var firstWidth  = firstLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var secondWidth = secondLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var thirdWidth  = thirdLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var fourthWidth = fouthLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var fifthWidth  = fifthLabel.widthAnchor.constraint(equalToConstant: 0)
    private lazy var sixthWidth  = sixthLabel.widthAnchor.constraint(equalToConstant: 0)
        
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Public Methods
    
    func configureHeader(viewModel: HistoricalHeaderViewModel?, byFrame rootView: UIView, and category: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            historicalStandingsStrategy = HistoricalDriverStrategy()
            historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
            historicalStandingsStrategy?.configureHeader(viewModel: viewModel, for: group().labels)
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            historicalStandingsStrategy = HistoricalConstructorStrategy()
            historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
            historicalStandingsStrategy?.configureHeader(viewModel: viewModel, for: group().labels)
        } else {
            historicalStandingsStrategy = HistoricalRaceStrategy()
            historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
            historicalStandingsStrategy?.configureHeader(viewModel: viewModel, for: group().labels)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        let stackView = UIStackView(
            arrangedSubviews: group().labels,
            axis: .horizontal,
            spacing: 0
        )
        
        self.addSubview(stackView)
        stackView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
        
        firstLabel.backgroundColor  = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        secondLabel.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        thirdLabel.backgroundColor  = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        fouthLabel.backgroundColor  = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        fifthLabel.backgroundColor  = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        sixthLabel.backgroundColor  = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
    private func group() -> (labels: [UILabel], widths: [NSLayoutConstraint?]) {
        return (
            labels: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            widths: [firstWidth, secondWidth, thirdWidth, fourthWidth, fifthWidth, sixthWidth]
        )
    }
}