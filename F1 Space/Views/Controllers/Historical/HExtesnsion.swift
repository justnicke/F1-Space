//
//  HExtesnsion.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 26.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import EMTNeumorphicView

extension HistoricalViewController {
    func set(for buttons: [EMTNeumorphicButton]) {
        buttons.forEach {
            $0.backgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
            $0.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.tintColor = .white
            $0.clipsToBounds = true
//            $0.layer.cornerRadius = 15
            $0.setNeumorphic()
        }
    }
    
    
    
    func setupTableView() {
        view.addSubview(canvasView)
//        canvasView.designSetup2()
        canvasView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.2760616408, green: 0.6389906679, blue: 1, alpha: 1) //view.backgroundColor?.cgColor ?? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        canvasView.neumorphicLayer?.cornerRadius = 15
        canvasView.neumorphicLayer?.depthType = .convex
        canvasView.neumorphicLayer?.elementDepth = 7
        canvasView.neumorphicLayer?.darkShadowOpacity = 0
        canvasView.neumorphicLayer?.lightShadowOpacity = 0.07

//        canvasView.layer.masksToBounds = true
//        canvasView.neumorphicLayer?.masksToBounds = false
        
        
        canvasView.anchor(top: topView.bottomAnchor,
                      leading: view.leadingAnchor,
                      bottom: view.bottomAnchor,
                      trailing: view.trailingAnchor,
                      padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
//        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.alwaysBounceVertical = true
        tableView.layer.cornerRadius = 15


        
        tableView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -110).isActive = true
        tableView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -5).isActive = true
        
        tableView.register(HistoricalCell.self, forCellReuseIdentifier: HistoricalCell.reuseId)
    }
    
    
    // MARK: - Private Methods
    
     func setupTopView() {
        view.addSubview(topView)
        topView.backgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
        topView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: 50)
        )
        
        set(for: [yearButton, categoryButton, detailResultButton])
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [yearButton, categoryButton, detailResultButton],
            axis: .horizontal,
            spacing: 10
        )
        
        topView.addSubview(buttonStackView)
        buttonStackView.anchor(
            top: topView.topAnchor,
            leading: topView.leadingAnchor,
            bottom: topView.bottomAnchor,
            trailing: topView.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
    }
    
     func initViewModel() {
        historicalViewModel = HistoricalViewModel(
            year: type().year,
            category: type().category,
            id: type().id)
    }

     func requestViewModel() {
        initViewModel()
        
        historicalViewModel.request() { [weak self] in
            let indexPath = IndexPath(row: 0, section: 0)
            
            self?.tableView.reloadData()
            self?.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    /// Quick access to the current state of the button text or identity
     func type() -> (year: String?, category: HistoricalCategory.RawValue?, detailed: String?, id: String?) {
        return (
            yearButton.titleLabel?.text,
            categoryButton.titleLabel?.text,
            detailResultButton.titleLabel?.text,
            detailResultID
        )
    }
    
     func openTransition(state: HistoricalPickerSelected, currentValues: [String?]) {
        let historicalPickerView = HistoricalPickerViewController(currentValues: currentValues, by: state)
        historicalPickerView.giveDelegate(for: self)
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        present(historicalPickerView, animated: true)
    }
    
    @objc  func yearButtonPressed() {
        openTransition(state: .yearChampionship, currentValues: [type().year, type().id, type().category])
    }
    
    @objc  func typeSearchButtonPressed() {
        openTransition(state: .category, currentValues: [type().category])
    }
    
    @objc  func detailResultButtonPressed() {
        openTransition(state: .detailedResult, currentValues: [type().year, type().detailed, type().category])
    }
}

// MARK: - Extension HistoricalPickerSelectedDelegate

extension HistoricalViewController: HistoricalPickerSelectedDelegate {
    
    func checkCorrectId(_ oldYear: String?) {
        if type().category == "Races" && type().detailed != "All" && type().year != oldYear {
            detailResultButton.setTitle("All", for: .normal)
            detailResultID = "All"
        }
    }
    
    func checkCorrectYearForTeam() {
        if type().category == "Teams" && type().year.unwrap < "1958" {
            yearButton.setTitle("1958", for: .normal)
        }
    }
    
    func year(currentСhampionship: String) {
        let oldYear = yearButton.titleLabel?.text
        
        yearButton.setTitle(String(currentСhampionship), for: .normal)
        
        checkCorrectId(oldYear)
        
        requestViewModel()
    }
    
    func category(current: String) {
        categoryButton.setTitle(current, for: .normal)
    
        detailResultButton.setTitle("All", for: .normal)
        detailResultID = "All"
        
        checkCorrectYearForTeam()
        
        requestViewModel()
    }
    
    func detailed(currentResult: String, id: String?) {
        detailResultButton.setTitle(currentResult, for: .normal)
        detailResultID = id ?? "All"
        
        requestViewModel()
    }
}

extension EMTNeumorphicButton{
    func setNeumorphic() {
//        self.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
//        self.neumorphicLayer?.cornerRadius = 15
//        self.neumorphicLayer?.depthType = .convex
//        self.neumorphicLayer?.elementDepth = 7
//        self.neumorphicLayer?.darkShadowOpacity = 0.9
//        self.neumorphicLayer?.lightShadowOpacity = 0.05
        
        self.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
        self.neumorphicLayer?.cornerRadius = 15
//        self.neumorphicLayer?.cornerType = .topRow
        self.neumorphicLayer?.depthType = .convex
        self.neumorphicLayer?.elementDepth = 5
        self.neumorphicLayer?.darkShadowOpacity = 0.5
        self.neumorphicLayer?.lightShadowOpacity = 0.07
    }
}

extension EMTNeumorphicView {
    func designSetup() {
        self.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
        self.neumorphicLayer?.cornerRadius = 15
//        self.neumorphicLayer?.cornerType
        self.neumorphicLayer?.depthType = .convex
        self.neumorphicLayer?.elementDepth = 7
        self.neumorphicLayer?.darkShadowOpacity = 0.7
        self.neumorphicLayer?.lightShadowOpacity = 0.08
    }
    
    func designSetup2() {
        self.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.1770213544, green: 0.1959984004, blue: 0.2182722688, alpha: 1)
//        self.neumorphicLayer?.cornerRadius = 15
        self.neumorphicLayer?.cornerType = .topRow
        self.neumorphicLayer?.depthType = .convex
        self.neumorphicLayer?.elementDepth = 7
        self.neumorphicLayer?.darkShadowOpacity = 0.5
        self.neumorphicLayer?.lightShadowOpacity = 0.07
    }
}
