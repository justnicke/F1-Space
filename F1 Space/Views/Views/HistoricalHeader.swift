//
//  HistoricalHeader.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 07.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalHeaderView: UIView, HistoricalViewType {
    
    // MARK: - Public Properties
    
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
    
//    private let lineView = UIView()
        
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    // MARK: - Public Methods
    
    func configure(_ viewModel: HistoricalHeaderViewModel?, byFrame superview: UIView, category: HistoricalCategory.RawValue?, and id: String?) {
        let insideCategory = HistoricalCategory(rawValue: category.unwrap.lowercased())
        
        switch insideCategory {
        case .drivers:
            configureDriver(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .header)
        case .teams:
            configureConstructor(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .header)
        case .races:
            configureRace(id: id)
            applyStrategy(viewModel, byFrame: superview, selected: .header)
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
        
//        self.addSubview(lineView)
//        lineView.backgroundColor = .gray
//        lineView.anchor(
//            top: topAnchor,
//            leading: leadingAnchor,
//            bottom: nil,
//            trailing: trailingAnchor,
//            size: .init(width: 0, height: 0.5)
//        )
    }
}
