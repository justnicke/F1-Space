//
//  HistoricalStandingsStrategyType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

protocol HistoricalStandingsStrategyType: class {
    var forThe: AuxiliaryNumbering { get }
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView)
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel])
    // naming and add headerVM
    func configureHeader(for labels: [UILabel], by model: HistoricalStandingsHeader)
}


