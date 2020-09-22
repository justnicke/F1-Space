//
//  HistoricalViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let topView = UIScrollView()
    private let yearButton: AutoSizeButton = {
        let button = AutoSizeButton(type: .custom)
        button.setTitle("2020", for: .normal)
        return button
    }()
    private let typeSearchButton: AutoSizeButton = {
        let button = AutoSizeButton(type: .custom)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    private let detailResultButton: AutoSizeButton = {
        let button = AutoSizeButton()
        button.setTitle("All", for: .normal)
        return button
    }()
    
    private var tableView: UITableView!
    
    private let extraResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Push", for: .normal)
        return button
    }()
    
    private let transition = PanelTransition()

    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupTopView()
        setupTableView()
        
        view.addSubview(extraResultButton)
        extraResultButton.backgroundColor = .red
        extraResultButton.centerInSuperview(size: .init(width: 150, height: 80))
        extraResultButton.addTarget(self, action: #selector(testAnimationPressed), for: .touchUpInside)
        
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        typeSearchButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
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
        
        set(for: [yearButton, typeSearchButton, detailResultButton])
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [yearButton, typeSearchButton, detailResultButton],
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func openTransition(state: PickerIndex, currentValues: [String?]) {
        let historicalPickerView = PickerViewController()
        historicalPickerView.giveDelegate(vc: self)
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        historicalPickerView.count = state
        historicalPickerView.currentValues.append(contentsOf: currentValues)
        
        present(historicalPickerView, animated: true)
    }
    
    @objc private func testAnimationPressed() {
        
    }
    
    @objc private func yearButtonPressed() {
        openTransition(state: .first, currentValues: [yearButton.titleLabel?.text])
    }
    
    @objc private func typeSearchButtonPressed() {
        openTransition(state: .second, currentValues: [typeSearchButton.titleLabel?.text])
    }
    
    @objc private func detailResultButtonPressed() {
        let currentValues = [yearButton.titleLabel?.text,
                             typeSearchButton.titleLabel?.text,
                             detailResultButton.titleLabel?.text]
        
        openTransition(state: .third, currentValues: currentValues)
    }
}

extension HistoricalViewController: PickerTypeDelegate {
    func year(value: Int) {
        yearButton.setTitle(String(value), for: .normal)
    }
    
    func type(result: String) {
        typeSearchButton.setTitle(result, for: .normal)
    }
    
    func result(value: String) {
        detailResultButton.setTitle(value, for: .normal)
    }
}

extension HistoricalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return UITableViewCell()
    }
    
    
}


