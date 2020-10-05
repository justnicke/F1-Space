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
    
    var standingStrategy: StandingsStrategy?
    
    // MARK: - Private Properties
    
    private var positionLabel: UILabel?
    private var any1Label: UILabel?
    private var any2Label: UILabel?
    private var any3Label: UILabel?
    private var any4Label: UILabel?
    private var any5Label: UILabel?
    
    private lazy var widthLabel = any2Label?.widthAnchor.constraint(equalToConstant: self.frame.width / 4)
    private lazy var widthLabel2 = positionLabel?.widthAnchor.constraint(equalToConstant: self.frame.width / 4)
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        positionLabel = UILabel()
        any1Label = UILabel()
        any2Label = UILabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    func constraintWidth() -> [NSLayoutConstraint]? {
//        
//        return [widthLabel]
//    }
    
    // MARK: - Public Methods
    
    func configure(driver: DriverStandings) {
        setupUI()
        standingStrategy = DriverStrategy()
        standingStrategy?.configureCell(for: [positionLabel, any1Label, any2Label, any3Label], result: ModelType(driver: driver))
    }
    
    func configureTeam(team: ConstructorStandings) {
        setupUITeam()
        standingStrategy = ConstructorStrategy()
        standingStrategy?.configureCell(for: [positionLabel, any1Label, any2Label], result: ModelType(constructor: team))
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        any3Label = UILabel()
        standingStrategy = DriverStrategy()
        standingStrategy?.setupUI(for: [positionLabel, any1Label, any2Label, any3Label], cell: self, widthConst: [widthLabel2, widthLabel])
    }

    private func setupUITeam() {
        any3Label?.removeFromSuperview()
        any3Label = nil
        
        standingStrategy = ConstructorStrategy()
        standingStrategy?.setupUI(for: [positionLabel, any1Label, any2Label], cell: self, widthConst: [widthLabel2, widthLabel])
    }
}
