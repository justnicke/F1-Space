//
//  UIButton.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        let width = self.titleLabel!.intrinsicContentSize.width + 20
        
        return CGSize(width: width, height: 30)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        })
    }
}
