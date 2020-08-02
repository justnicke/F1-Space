//
//  CustromActivityIndicator.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustromActivityIndicator: UIView {
    
    // MARK: - Public Properties
    
    /// Сolor of the activity indicator
    var color: UIColor = .black  {
        didSet {
            indicatorShapeLayer.strokeColor = color.cgColor
        }
    }
    
    /// Width of the activity indicator line
    var lineWidth: CGFloat = 3 {
        didSet {
            indicatorShapeLayer.lineWidth = lineWidth
        }
    }
    
    /// Diameter of the activity indicator
    var diameter: CGFloat = 37
    
    // MARK: - Private Properties
    
    private let indicatorShapeLayer = CAShapeLayer()
    private let animation = CustomAnimationActivityIndicator()
    private var isAnimating = false
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIndicatorShapeLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Starts the animation of the progress indicator
    func startAnimating() {
        isAnimating = true
        animation.addAnimation(layer: indicatorShapeLayer)
    }
    
    /// Stops the animation of the progress indicator
    func stopAnimating() {
        isAnimating = false
        animation.removeAnimation(layer: indicatorShapeLayer)
    }
    
    // MARK: - Private Methods
    
    private func setupIndicatorShapeLayer() {
        indicatorShapeLayer.strokeColor = color.cgColor
        indicatorShapeLayer.fillColor = nil
        indicatorShapeLayer.lineWidth = lineWidth
        indicatorShapeLayer.frame = bounds
        indicatorShapeLayer.strokeStart = 0.0
        indicatorShapeLayer.strokeEnd = 0.0
        layer.addSublayer(indicatorShapeLayer)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
            radius: diameter / 2,
            startAngle: 0,
            endAngle: CGFloat(.pi * 2.0),
            clockwise: true
        )
        
        indicatorShapeLayer.path = circlePath.cgPath
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
