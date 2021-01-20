//
//  HistoricalPickerViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class HistoricalPickerViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var count = HistoricalPickerSelected(rawValue: .zero)
    var currentValues: [String?] = []
    private var picker = UIPickerView()
    private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.tintColor = .red
//        button.neumorphicLayer?.elementBackgroundColor = UIColor.mainDark.cgColor
//        button.neumorphicLayer?.cornerRadius = 15
//        button.neumorphicLayer?.depthType = .convex
//        button.neumorphicLayer?.elementDepth = 5
//        button.neumorphicLayer?.darkShadowOpacity = 0.9
//        button.neumorphicLayer?.lightShadowOpacity = 0.08
        button.alpha = 0.5
        return button
    }()
    private let handleDismissView = UIView()
    private lazy var historicalPickerViewModel = HistoricalPickerViewModel(currentValues: currentValues, by: count)
    
    let neumorphicView = UIView()
    
    // MARK: - Constructors
    
    init(currentValues: [String?], by state: HistoricalPickerSelected?) {
        super.init(nibName: nil, bundle: nil)
        self.currentValues = currentValues
        self.count = state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = .milkyGrey
        
        setupUI()
        updateViewModel()
        
        picker.addSubview(neumorphicView)
        
//        neumorphicView.neumorphicLayer?.elementBackgroundColor = view.backgroundColor?.cgColor ?? UIColor.mainDark.cgColor
//        neumorphicView.neumorphicLayer?.cornerRadius = 15
//        neumorphicView.neumorphicLayer?.depthType = .concave
//        neumorphicView.neumorphicLayer?.elementDepth = 5
//        neumorphicView.neumorphicLayer?.darkShadowOpacity = 0.9
//        neumorphicView.neumorphicLayer?.lightShadowOpacity = 0.08
        neumorphicView.alpha = 0.5

        doneButton.addTarget(self, action: #selector(handleReturnValue), for: .touchUpInside)
    }
    
    func giveDelegate(for vc: UIViewController) {
        historicalPickerViewModel.delegate = vc as? HistoricalPickerSelectedDelegate
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        handleDismissView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        view.addSubview(handleDismissView)
        handleDismissView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: 60)
        )
        
        view.addSubview(doneButton)
        doneButton.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 30, bottom: 30, right: 30),
            size: .init(width: 0, height: 60)
        )
    }
    
    private func initPicker() {
        view.addSubview(picker)
        picker.anchor(
            top: handleDismissView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: doneButton.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0)
        )
        
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func updateViewModel() {
        historicalPickerViewModel.requestForSelection() { [weak self] in
            self?.picker.reloadAllComponents()
            self?.initPicker()
            self?.currentPickerValue()
        }
    }
    
    private func currentPickerValue() {
        let row = historicalPickerViewModel.selectedRowPicker()
        picker.selectRow(row, inComponent: 0, animated: false)
    }
    
    @objc private func handleReturnValue() {
        let selectedRow = picker.selectedRow(inComponent: 0)
        
        dismiss(animated: true) {
            self.historicalPickerViewModel.sendValueFromPicker(row: selectedRow)
        }
    }
}

// MARK: - Extension UIPickerViewDataSource & UIPickerViewDelegate

extension HistoricalPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return historicalPickerViewModel.numberOfRowsInComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return historicalPickerViewModel.titleForRow(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for lineSubview in pickerView.subviews {
            var frame = lineSubview.frame
            frame.size.height = 52
            lineSubview.frame = frame
            neumorphicView.frame = lineSubview.frame
            lineSubview.backgroundColor = UIColor
                .init(red: 0.180019021, green: 0.2043099701, blue: 0.2299311161, alpha: 1).withAlphaComponent(0.01)
        }

        var label = view as! UILabel?
        
        if label == nil {
            label = UILabel()
        }
        
        let title = NSAttributedString()
        
        label?.attributedText = historicalPickerViewModel.viewForRow(
            row,
            with: title,
            and: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22)!]
        )
        label?.textColor = .white
        label?.textAlignment = .center
        
        return label ?? UIView()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
