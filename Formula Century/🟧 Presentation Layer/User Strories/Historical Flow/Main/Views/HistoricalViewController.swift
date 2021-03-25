//
//  HistoricalViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import Combine

final class HistoricalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    let topView = UIScrollView()
    let yearButton: CustomButton = {
        let button = CustomButton(type: .custom)
        return button
    }()
    let categoryButton: CustomButton = {
        let button = CustomButton(type: .custom)
        
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    let detailResultButton: CustomButton = {
        let button = CustomButton(type: .custom)
        button.setTitle("All", for: .normal)
        return button
    }()
    var detailResultID = "All"
    var tableView: UITableView!
    let transition = PanelTransition()
    let header = HistoricalHeaderView()
    var historicalViewModel: HistoricalViewModel!
    
    var firstYear: [String: Bool]?
        
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        yearButton.setTitle(firstYear?.keys.first, for: .normal)
        setupTopView()
        requestViewModel()
        setupTableView()
        
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
        detailResultButton.addTarget(self, action: #selector(detailResultButtonPressed), for: .touchUpInside)

        
    }
    
    func set(for buttons: [CustomButton]) {
        buttons.forEach {
            $0.backgroundColor = .white
            $0.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(.gray, for: .highlighted)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        
        tableView.anchor(top: topView.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor)
        
        tableView.register(HistoricalCell.self, forCellReuseIdentifier: HistoricalCell.reuseId)
    }
    
    func setupTopView() {
        view.addSubview(topView)
        topView.backgroundColor = .topH
        topView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: 50)
        )
        
        
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [yearButton, categoryButton, detailResultButton],
            axis: .horizontal,
            spacing: 10
        )
        set(for: [yearButton, categoryButton, detailResultButton])
        
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
            self?.view.setGradient()
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
        openTransition(state: .yearChampionship, currentValues: [type().year, type().id, type().category, String((firstYear?.values.first)!)])
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
    
    func push<ViewModel>(for viewController: BaseHistoricalDetailViewController<ViewModel>) {
        navigationController?.pushViewController(viewController, animated: true)
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
        
        let colors = [UIColor.white, .white]
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(historicalViewModel.heightForRow())
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModelHeader = historicalViewModel.viewForHeader()
        header.configure(viewModelHeader, byFrame: view, category: type().category, and: type().id)
        header.backgroundColor = #colorLiteral(red: 0.2000292838, green: 0.2056119144, blue: 0.3388276696, alpha: 1)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(historicalViewModel.heightForHeader())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = HistoricalCategory(rawValue: type().category.unwrap.lowercased())
        let detailViewModel = historicalViewModel.didSelectRowAt(indexPath: indexPath)
        
        switch category {
        case .drivers:
            switch type().detailed.isAll() {
            case true:  push(for: HistoricalCurrentDriverViewController(viewModel: detailViewModel as? HistoricalCurrentDriverViewModel))
            case false: push(for: HistoricalDriverDetailViewController(viewModel: detailViewModel as? HistoricalDriverDetailViewModel))
            }
        case .teams:
            switch type().detailed.isAll() {
            case true:  push(for: HistoricalConstructorStandingsViewController(viewModel: detailViewModel as? HistoricalConstructorStandingsViewModel))
            case false: push(for: HistoricalConstructorDetailViewController(viewModel: detailViewModel as? HistoricalConstructorDetailViewModel))
            }
        case .races:
            switch type().detailed.isAll() {
            case true:  push(for: HistoricalRacesViewController(viewModel: detailViewModel as? HistoricalRacesViewModel))
            case false: push(for: HistoricalRaceDetailViewController(viewModel: detailViewModel as? HistoricalRaceDetailViewModel))
            }
        default: fatalError("This shouldn't happen at all! Func: \(#function)")
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
