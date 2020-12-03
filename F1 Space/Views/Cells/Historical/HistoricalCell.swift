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
    
    private var historicalStandingsStrategy: HistoricalStandingsStrategy?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureCell(viewModel: HistoricalCellViewModel?, byFrame rootView: UIView, and category: String?, id: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                historicalStandingsStrategy = HistoricalDriverStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            } else {
                historicalStandingsStrategy = HistoricalDriverDetailStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                historicalStandingsStrategy = HistoricalConstructorStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            } else {
                historicalStandingsStrategy = HistoricalConstructorDetailStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            }
        } else {
            if id == "All" {
                historicalStandingsStrategy = HistoricalRaceStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            } else {
                historicalStandingsStrategy = HistoricalRaceDetailStrategy()
                historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: rootView)
                historicalStandingsStrategy?.configureCell(viewModel: viewModel, for: group().labels)
            }
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
        
        group().labels.forEach {
            $0.backgroundColor = .mainDark
        }
    }
    
    private func group() -> (labels: [UILabel], widths: [NSLayoutConstraint?]) {
        return (
            labels: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            widths: [firstWidth, secondWidth, thirdWidth, fourthWidth, fifthWidth, sixthWidth]
        )
    }
}
