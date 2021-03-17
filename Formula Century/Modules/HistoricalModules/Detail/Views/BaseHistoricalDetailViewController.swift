//
//  BaseHistoricalDetailViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

class BaseHistoricalDetailViewController<ViewModel>: UIViewController {
    var viewModel: ViewModel?

    init(viewModel: ViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
