//
//  HistoricalViewType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

enum HistoricalSelectedViewType {
    case cell
    case header
}

/// Properties for the historical cell and header
protocol HistoricalViewPropertyble: class {
    var firstLabel:  UILabel { get }
    var secondLabel: UILabel { get }
    var thirdLabel:  UILabel { get }
    var fouthLabel:  UILabel { get }
    var fifthLabel:  UILabel { get }
    var sixthLabel:  UILabel { get }
    
    var firstWidth:  NSLayoutConstraint { get }
    var secondWidth: NSLayoutConstraint { get }
    var thirdWidth:  NSLayoutConstraint { get }
    var fourthWidth: NSLayoutConstraint { get }
    var fifthWidth:  NSLayoutConstraint { get }
    var sixthWidth:  NSLayoutConstraint { get }
}

protocol HistoricalViewType: HistoricalViewPropertyble {
    associatedtype HistoricalViewModel
    var historicalStandingsStrategy: HistoricalStandingsStrategy? { get set }
    func configure(_ viewModel: HistoricalViewModel?, byFrame superview: UIView, category: HistoricalCategory.RawValue?, and id: String?)
}

extension HistoricalViewType {
    func configureDriver(id: String?) {
        switch id.isAll() {
        case true:  historicalStandingsStrategy = HistoricalDriverStrategy()
        case false: historicalStandingsStrategy = HistoricalDriverDetailStrategy()
        }
    }
    
    func configureConstructor(id: String?) {
        switch id.isAll() {
        case true:  historicalStandingsStrategy = HistoricalConstructorStrategy()
        case false: historicalStandingsStrategy = HistoricalConstructorDetailStrategy()
        }
    }
    
    func configureRace(id: String?) {
        switch id.isAll() {
        case true:  historicalStandingsStrategy = HistoricalRaceStrategy()
        case false: historicalStandingsStrategy = HistoricalRaceDetailStrategy()
        }
    }
    
    func applyStrategy(_ viewModel: HistoricalViewModel?, byFrame superview: UIView, selected viewType: HistoricalSelectedViewType) {
        historicalStandingsStrategy?.setupUI(for: group().labels, withAdjustable: group().widths, byFrame: superview)
        
        switch viewType {
        case .cell:
            historicalStandingsStrategy?.configureCell(viewModel: viewModel as? HistoricalCellViewModel, for: group().labels)
        case .header:
            historicalStandingsStrategy?.configureHeader(viewModel: viewModel as? HistoricalHeaderViewModel, for: group().labels)
        }
    }
    
    func group() -> (labels: [UILabel], widths: [NSLayoutConstraint?]) {
        return (
            labels: [firstLabel, secondLabel, thirdLabel, fouthLabel, fifthLabel, sixthLabel],
            widths: [firstWidth, secondWidth, thirdWidth, fourthWidth, fifthWidth, sixthWidth]
        )
    }
}
