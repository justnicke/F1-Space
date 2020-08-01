//
//  RefreshView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class RefreshView: UIView {
    
    private let activityIndicator = CustromActivityIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActivityIndicator() {
        self.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.color = .red
        activityIndicator.startAnimating()
    }
}
