//
//  HistoricalStandingsStrategyType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

protocol HistoricalStandingsStrategy: class {
    var forThe: AuxiliaryNumbering { get }
    func setupUI(for labels: [UILabel], withAdjustable width: [NSLayoutConstraint?], byFrame rootView: UIView)
    func configureCell(viewModel: HistoricalCellViewModel?, for labels: [UILabel])
    func configureHeader(viewModel: HistoricalHeaderViewModel?, for labels: [UILabel])
}


