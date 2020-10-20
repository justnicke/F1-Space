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
    
    private let topView = UIScrollView()
    private let yearButton: AutoSizeButton = {
        let button = AutoSizeButton(type: .custom)
        button.setTitle("2020", for: .normal)
        return button
    }()
    private let categoryButton: AutoSizeButton = {
        let button = AutoSizeButton(type: .custom)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    private let detailResultButton: AutoSizeButton = {
        let button = AutoSizeButton()
        button.setTitle("All", for: .normal)
        return button
    }()
    private var detailResultID = "All"
    private var tableView: UITableView!
    private let transition = PanelTransition()
    private let header = HistoricalHeaderView()
    private var historicalViewModel = HistoricalViewModel()
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupTopView()
        requestViewModel()
        setupTableView()
        
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
        detailResultButton.addTarget(self, action: #selector(detailResultButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func setupTopView() {
        view.addSubview(topView)
        topView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
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
    
    private func set(for buttons: [AutoSizeButton]) {
        buttons.forEach {
            $0.backgroundColor = #colorLiteral(red: 0.6764943004, green: 0.6070100665, blue: 0.899546206, alpha: 1)
            $0.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.tintColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(HistoricalCell.self, forCellReuseIdentifier: HistoricalCell.reuseId)
    }
    
    private func requestViewModel() {
        historicalViewModel.request(
            current: type().category,
            inThat: type().year,
            id: type().id) { [weak self] in
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            self?.tableView.reloadData()
            self?.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    /// Quick access to the current state of the button text or identity
    private func type() -> (year: String?, category: String?, detailed: String?, id: String?) {
        return (
            yearButton.titleLabel?.text,
            categoryButton.titleLabel?.text,
            detailResultButton.titleLabel?.text,
            detailResultID
        )
    }
    
    private func openTransition(state: HistoricalPickerSelected, currentValues: [String?]) {
        let historicalPickerView = HistoricalPickerViewController()
        historicalPickerView.giveDelegate(for: self)
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        historicalPickerView.count = state
        historicalPickerView.currentValues.append(contentsOf: currentValues)
        
        present(historicalPickerView, animated: true)
    }
    
    @objc private func yearButtonPressed() {
        openTransition(state: .yearChampionship, currentValues: [type().year])
    }
    
    @objc private func typeSearchButtonPressed() {
        openTransition(state: .category, currentValues: [type().category])
    }
    
    @objc private func detailResultButtonPressed() {
        let currentValues = [type().year,
                             type().category,
                             type().detailed]
        
        openTransition(state: .detailedResult, currentValues: currentValues)
    }
}

// MARK: - Extension UITableViewDataSource & UITableViewDelegate

extension HistoricalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalViewModel.numberOfRows(inCurrent: type().category)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricalCell.reuseId, for: indexPath) as! HistoricalCell
        let viewModelCell = historicalViewModel.cellForRowAt(indexPath: indexPath, inCurrent: categoryButton.titleLabel?.text)
        cell.configureCell(viewModel: viewModelCell, byFrame: view, and: type().category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModelHeader = historicalViewModel.viewForHeader(in: section, currentCategory: type().category)
        header.configureHeader(viewModel: viewModelHeader, byFrame: view, and: type().category)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - Extension HistoricalPickerSelectedDelegate

extension HistoricalViewController: HistoricalPickerSelectedDelegate {
    func year(currentСhampionship: Int) {
        yearButton.setTitle(String(currentСhampionship), for: .normal)
        requestViewModel()
    }
    
    func category(current: String) {
        categoryButton.setTitle(current, for: .normal)
        requestViewModel()
    }
    
    func detailed(currentResult: String, id: String) {
        detailResultButton.setTitle(currentResult, for: .normal)
        detailResultID = id
        requestViewModel()
    }
}




