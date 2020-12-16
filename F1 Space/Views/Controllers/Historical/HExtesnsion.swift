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
            $0.backgroundColor = .mainDark
            $0.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.tintColor = .white
            $0.clipsToBounds = true
            $0.setDesignForFilterButton()
        }
    }
    
    func setupHeaderView() {
        view.addSubview(header)
        header.anchor(
            top: topView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: tableView.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 5, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 40)
        )
        
        let viewModelHeader = historicalViewModel.viewForHeader()
        header.configure(viewModelHeader, byFrame: view, category: type().category, and: type().id)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        setupHeaderView()
    
        tableView.anchor(top: header.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 74, right: 0))
        
        tableView.register(HistoricalCell.self, forCellReuseIdentifier: HistoricalCell.reuseId)
    }
    
    func setupTopView() {
        view.addSubview(topView)
        topView.backgroundColor = .mainDark
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
        historicalViewModel = HistoricalViewModel(year: type().year,
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
    
    private func checkCorrectId(_ oldYear: String?) {
        if type().category == "Races" && type().detailed != "All" && type().year != oldYear {
            detailResultButton.setTitle("All", for: .normal)
            detailResultID = "All"
        }
    }
    
    private func checkCorrectYearForTeam() {
        if type().category == "Teams" && type().year.unwrap < "1958" {
            yearButton.setTitle("1958", for: .normal)
        }
    }
}

// MARK: - Extension HistoricalPickerSelectedDelegate

extension HistoricalViewController: HistoricalPickerSelectedDelegate {
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



