//
//  DuelView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 04.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class DuelView: UIView {
    // Container
    @IBOutlet var contentView: UIView!
    // Top
    @IBOutlet var driverNameLabel: UILabel!
    @IBOutlet var teammateNameLabel: UILabel!
    // Center
    @IBOutlet var qualuficationView: UIView!
    @IBOutlet var qualificationLabel: UILabel!
    @IBOutlet var driverQualiScoreLabel: UILabel!
    @IBOutlet var teammateQualiScoreLabel: UILabel!
    // Bottom
    @IBOutlet var raceView: UIView!
    @IBOutlet var raceLabel: UILabel!
    @IBOutlet var driverRaceScoreLabel: UILabel!
    @IBOutlet var teammateRaceScoreLabel: UILabel!
    
    // Graphs
    @IBOutlet var driverQualiScoreView: UIView!
    @IBOutlet var teammateQualiScoreView: UIView!
    @IBOutlet var driverRaceScoreView: UIView!
    @IBOutlet var teammateRaceScoreView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DuelView", owner: self, options: nil)
        self.backgroundColor = .clear
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .topH
        contentView.layer.cornerRadius = 10
    }
    
    private func setupUIElements() {
        [driverNameLabel, teammateNameLabel].forEach {
            $0?.customizeLabelForDuelViewDriverName()
        }
        
        [qualificationLabel, driverQualiScoreLabel, teammateQualiScoreLabel,
         raceLabel, driverRaceScoreLabel, teammateRaceScoreLabel].forEach {
            $0?.customizeLabelForDuelViewGraphs()
        }
        
        driverQualiScoreView.customizeGraphForDuelViewLeft()
        driverRaceScoreView.customizeGraphForDuelViewLeft()
        teammateQualiScoreView.customizeGraphForDuelViewRight()
        teammateRaceScoreView.customizeGraphForDuelViewRight()
    }
}

extension UIView {
    func customizeGraphForDuelViewLeft() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = 5
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func customizeGraphForDuelViewRight() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = 5
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
}

extension UILabel {
    func customizeLabelForDuelViewGraphs() {
        self.textColor = .white
        self.font = UIFont.init(name: "AvenirNext-Bold", size: 14)
    }
    
    func customizeLabelForDuelViewDriverName() {
        self.textColor = .white
        self.font = UIFont.init(name: "AvenirNext-Bold", size: 16)
    }
}
