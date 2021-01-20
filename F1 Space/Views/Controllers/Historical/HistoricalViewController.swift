//
//  HistoricalViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalViewController: UIViewController {
    
    // MARK: - Private Properties
    let topView = UIScrollView()
    let yearButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("2020", for: .normal)
        return button
    }()
    let categoryButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    let detailResultButton: CustomButton = {
        let button = CustomButton(type: .system)
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
        
        view.backgroundColor = .milkyGrey
        
        setupTopView()
        requestViewModel()
        setupTableView()
  
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
        detailResultButton.addTarget(self, action: #selector(detailResultButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        let maskLayer = CAShapeLayer()
//        let border = CAShapeLayer()
//
//        maskLayer.frame = tableView.bounds
//        maskLayer.path = UIBezierPath(roundedRect: tableView.bounds,
//                                      byRoundingCorners: .allCorners,
//                                 cornerRadii: CGSize(width: 10, height: 10)).cgPath
//        tableView.layer.mask = maskLayer
//
//       border.path = maskLayer.path
//        border.fillColor = UIColor.clear.cgColor
//        border.strokeColor = UIColor.gray.cgColor
//        border.lineWidth = 1
//        border.frame = tableView.bounds
//        tableView.layer.addSublayer(border)
        header.addBottomShadow()
//        let buttonHeight = header.frame.height
//        let buttonWidth = header.frame.width
//
//        let shadowSize: CGFloat = 15
//        let contactRect = CGRect(x: -shadowSize, y: buttonHeight - (shadowSize * 0.2), width: buttonWidth + shadowSize * 2, height: shadowSize)
//        header.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
//        header.layer.shadowRadius = 5
//        header.layer.shadowOpacity = 0.6
        
//        header.layer.masksToBounds = false
//        header.layer.shadowOffset = CGSize(width: 0, height: 0)
//        header.layer.shadowRadius = 2
//        header.layer.shadowOpacity = 0.5
//        header.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}

extension UIView {
func addBottomShadow() {
    layer.masksToBounds = false
    layer.shadowRadius = 0.5
    layer.shadowOpacity = 0.5
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0 , height: 3)
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
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
        
        let colors = [UIColor.milkyGrey, .milkyGrey]
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
