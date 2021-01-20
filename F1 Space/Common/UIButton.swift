//
//  UIButton.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {
    let maskLayer = CAShapeLayer()
    let border = CAShapeLayer()
    
    override var intrinsicContentSize: CGSize {
        let width = self.titleLabel!.intrinsicContentSize.width + 20
        
        return CGSize(width: width, height: 30)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.maskLayer.frame = self.bounds
            self.maskLayer.path = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: .allCorners,
                                     cornerRadii: CGSize(width: 15, height: 15)).cgPath
            self.layer.mask = self.maskLayer

            self.border.path = self.maskLayer.path
            self.border.fillColor = UIColor.clear.cgColor
            self.border.strokeColor = UIColor.gray.cgColor
            self.border.lineWidth = 1
            self.border.frame = self.bounds
            self.layer.addSublayer(self.border)
            
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        })
    }
}
