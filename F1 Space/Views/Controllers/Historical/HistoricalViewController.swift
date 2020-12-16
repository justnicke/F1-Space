//
//  HistoricalViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import EMTNeumorphicView

final class HistoricalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    let topView = UIScrollView()
    let yearButton: EMTNeumorphicButton = {
        let button = EMTNeumorphicButton(type: .custom)
        button.setTitle("2020", for: .normal)
        return button
    }()
    let categoryButton: EMTNeumorphicButton = {
        let button = EMTNeumorphicButton(type: .custom)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    let detailResultButton: EMTNeumorphicButton = {
        let button = EMTNeumorphicButton()
        button.setTitle("All", for: .normal)
        return button
    }()
    var detailResultID = "All"
    var tableView: UITableView!
    let transition = PanelTransition()
    let header = HistoricalHeaderView()
    var historicalViewModel: HistoricalViewModel!
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        
        setupTopView()
        requestViewModel()
        setupTableView()
        
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
        detailResultButton.addTarget(self, action: #selector(detailResultButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Extension UITableViewDataSource & UITableViewDelegate

extension HistoricalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricalCell.reuseId, for: indexPath) as! HistoricalCell
        let viewModelCell = historicalViewModel.cellForRowAt(indexPath: indexPath)
        cell.configure(viewModelCell, byFrame: view, category: type().category, and: type().id)
        
        let colors = [#colorLiteral(red: 0.1770535707, green: 0.1963185668, blue: 0.2220225334, alpha: 1), .mainDark]
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}





