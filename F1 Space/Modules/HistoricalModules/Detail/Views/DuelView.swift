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
    
    // Layer and precent
    let qualiDriverLayer = CAShapeLayer()
    let qualiDriverPercent: CGFloat = 0.5
    let raceDriverLayer = CAShapeLayer()
    let raceDriverPercent: CGFloat = 0.5
    
    let qualiTeammateLayer = CAShapeLayer()
    let qualiTeammatePercent: CGFloat = 0.5
    let raceTeammateLayer = CAShapeLayer()
    let raceTeammatePercent: CGFloat = 0.5
    
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

    override func layoutSubviews() {
        set(
            shape: qualiDriverLayer,
            typeView: driverQualiScoreView,
            precent: qualiDriverPercent,
            moveX: 0,
            addX: driverQualiScoreView.bounds.width,
            color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            )
        
        set(
            shape: raceDriverLayer,
            typeView: driverRaceScoreView,
            precent: raceDriverPercent,
            moveX: 0,
            addX: driverRaceScoreView.bounds.width,
            color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            )
        
        set(
            shape: qualiTeammateLayer,
            typeView: teammateQualiScoreView,
            precent: qualiTeammatePercent,
            moveX: teammateQualiScoreView.bounds.width,
            addX: 0,
            color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            )
        
        set(
            shape: raceTeammateLayer,
            typeView: teammateRaceScoreView,
            precent: raceTeammatePercent,
            moveX: teammateRaceScoreView.bounds.width,
            addX: 0,
            color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            )
    }
    
    func set(shape: CAShapeLayer, typeView: UIView, precent: CGFloat, moveX: CGFloat, addX: CGFloat, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: moveX, y: typeView.bounds.midY))
        path.addLine(to: CGPoint(x: addX, y: typeView.bounds.midY))
        
        shape.path = path.cgPath
        shape.frame = typeView.bounds
        shape.strokeColor = color.cgColor
        shape.lineWidth = typeView.bounds.height
        shape.strokeStart = precent // 0.1 это 90% - 0.9 это 10%
        
        typeView.layer.addSublayer(shape)
        typeView.clipsToBounds = true
        
        shape.add(startAnimation(precent: precent), forKey: "strokeStart")
    }
    
    private func startAnimation(precent: CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.duration = 3
        animation.fromValue = 1
        animation.toValue = precent // 0.1 это 90% - 0.9 это 10%
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    func configure() {
        
    }
    
//    var items = ["russel": ["qualification": 0]]
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

