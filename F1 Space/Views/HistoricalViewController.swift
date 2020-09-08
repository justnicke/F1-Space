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
    
    private let topView = UIScrollView()
    private let yearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2020", for: .normal)
        return button
    }()
    private let typeSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    private let detailResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("All", for: .normal)
        return button
    }()
    private let extraResultButton = UIButton(type: .system)
    
//    private let transition = PanelTransition()
    
    private let testFunctionallityButton = UIButton(type: .system)

    // MARK: - Private Properties
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupTopView()
        
//        view.addSubview(testFunctionallityButton)
//        testFunctionallityButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        testFunctionallityButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        testFunctionallityButton.centerInSuperview()
//        testFunctionallityButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        testFunctionallityButton.setTitle("Test", for: .normal)
        
        yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        typeSearchButton.addTarget(self, action: #selector(typeSearchButtonPressed), for: .touchUpInside)
        detailResultButton.addTarget(self, action: #selector(detailResultButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func setupTopView() {
        view.addSubview(topView)
        topView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        topView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: 50)
        )
        
        set(for: [yearButton, typeSearchButton, detailResultButton, extraResultButton])
        
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [yearButton, typeSearchButton, detailResultButton, extraResultButton],
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
        
        animation(for: yearButton)
        animation(for: typeSearchButton)
        animation(for: detailResultButton)
    }
    
    private func set(for buttons: [UIButton]) {
        buttons.forEach {
            $0.backgroundColor = #colorLiteral(red: 0.6764943004, green: 0.6070100665, blue: 0.899546206, alpha: 1)
            $0.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.tintColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
        buttons.last?.isHidden = true
    }
    
    private func animation(for button: UIButton) {
        if button.frame.width != 51 {
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) { [unowned self] in
                button.widthAnchor.constraint(equalToConstant: button.frame.width + 20).isActive = true
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func yearButtonPressed() {
        let transition = PanelTransition()
        let historicalPickerView = PickerViewController()
        historicalPickerView.delegate = self
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        historicalPickerView.supportingValue = yearButton.titleLabel?.text
        present(historicalPickerView, animated: true)
    }
    
    @objc private func typeSearchButtonPressed() {
        let transition = PanelTransition()
        let historicalPickerView = PickerViewController()
        historicalPickerView.delegate = self
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        historicalPickerView.supportingValue2 = typeSearchButton.titleLabel?.text
        present(historicalPickerView, animated: true)
    }
    
    @objc private func detailResultButtonPressed() {
        let transition = PanelTransition()
        let historicalPickerView = PickerViewController()
        historicalPickerView.delegate = self
        historicalPickerView.transitioningDelegate = transition
        historicalPickerView.modalPresentationStyle = .custom
        historicalPickerView.supportingValue3 = yearButton.titleLabel?.text
        historicalPickerView.supportingValue4 = typeSearchButton.titleLabel?.text
        historicalPickerView.supportingValue5 = detailResultButton.titleLabel?.text
        present(historicalPickerView, animated: true)
    }
}

extension HistoricalViewController: PickerType {
    func year(value: Int) {
        yearButton.setTitle(String(value), for: .normal)
        animation(for: yearButton)
    }
    
    func type(result: String) {
        typeSearchButton.setTitle(result, for: .normal)
    }
    
    func result(value: String) {
        detailResultButton.setTitle(value, for: .normal)
    }
}
