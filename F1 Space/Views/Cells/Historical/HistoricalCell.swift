//
//  HistoricalCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 24.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit



final class HistoricalCell: UITableViewCell, HistoricalViewType {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: HistoricalCell.self)
    var historicalStandingsStrategy: HistoricalStandingsStrategy?
    
    // MARK: - Private Properties
    
    private(set) var firstLabel  = UILabel()
    private(set) var secondLabel = UILabel()
    private(set) var thirdLabel  = UILabel()
    private(set) var fouthLabel  = UILabel()
    private(set) var fifthLabel  = UILabel()
    private(set) var sixthLabel  = UILabel()
    
    private(set) lazy var firstWidth  = firstLabel.widthAnchor.constraint(equalToConstant: 0)
    private(set) lazy var secondWidth = secondLabel.widthAnchor.constraint(equalToConstant: 0)
    private(set) lazy var thirdWidth  = thirdLabel.widthAnchor.constraint(equalToConstant: 0)
    private(set) lazy var fourthWidth = fouthLabel.widthAnchor.constraint(equalToConstant: 0)
    private(set) lazy var fifthWidth  = fifthLabel.widthAnchor.constraint(equalToConstant: 0)
    private(set) lazy var sixthWidth  = sixthLabel.widthAnchor.constraint(equalToConstant: 0)
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(_ viewModel: HistoricalCellViewModel?, byFrame superview: UIView, category: HistoricalCategory.RawValue?, and id: String?) {
        let insideCategory = HistoricalCategory(rawValue: category.unwrap.lowercased())
        
        switch insideCategory {
        case .drivers:
            configureDriver(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .cell)
        case .teams:
            configureConstructor(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .cell)
        case .races:
            configureRace(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .cell)
        default:
            fatalError("This shouldn't happen at all! Func: \(#function)")
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
    }
}
