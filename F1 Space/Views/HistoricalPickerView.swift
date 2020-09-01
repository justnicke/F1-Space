//
//  HistoricalPickerView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

protocol PickerType: class {
    func year(value: Int)
}

final class HistoricalPickerView: UIView {
    
    // MARK: - Public Properties
    
    weak var delegate: PickerType?
    var yearCount: String?
    
    // MARK: - Private Properties
    
    private var picker = UIPickerView()
    private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.tintColor = #colorLiteral(red: 0.3819147944, green: 0.3267760873, blue: 0.8082862496, alpha: 1)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        let opacity: CGFloat = 0.3
        let borderColor = #colorLiteral(red: 0.3819147944, green: 0.3267760873, blue: 0.8082862496, alpha: 1)
        button.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        return button
    }()
    private let testTopView = UIView()
    private var championships = [Int]()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        requestDates()
        setupUI()
        
        doneButton.addTarget(self, action: #selector(getValueFromPicker), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupUI() {
        testTopView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
     
        addSubview(testTopView)
        testTopView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            size: .init(width: 0, height: 60)
        )
        
        addSubview(doneButton)
        doneButton.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 30, bottom: 30, right: 30),
            size: .init(width: 0, height: 60)
        )
        
        addSubview(picker)
        picker.anchor(
            top: testTopView.bottomAnchor,
            leading: leadingAnchor,
            bottom: doneButton.topAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0)
        )
        
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func requestDates() {
        API.requestYearChampionship { [weak self] (dates, error) in
            self?.yearCount = dates?.championship.yearsCount
            self?.getChampionshipYear()
            self?.picker.reloadAllComponents()
        }
    }
    
    private func getChampionshipYear() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if let string = yearCount, let convertedYearCount = Int(string) {
            for i in 0...convertedYearCount - 1 {
                let year = currentYear - i
                championships.append(year)
            }
        }
    }
    
    @objc private func getValueFromPicker() {
        
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selectedValue = championships[selectedRow]
        delegate?.year(value: selectedValue)
    }
}

// MARK: - Extension CollectionViewDataSource & CollectionViewDelegate

extension HistoricalPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return championships.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(championships[row])
    }
        
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
        for lineSubview in pickerView.subviews {
            if lineSubview.frame.size.height < 1 {
                var frame = lineSubview.frame
                frame.size.height = 2
                lineSubview.frame = frame
                lineSubview.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            }
        }
        
        var label = view as! UILabel?
        
        if label == nil {
            label = UILabel()
        }
    
        let title = NSAttributedString(
            string: String(championships[row]),
            attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont()]
        )
        
        label?.attributedText = title
        label?.textColor = #colorLiteral(red: 0.3819147944, green: 0.3267760873, blue: 0.8082862496, alpha: 1)
        label?.textAlignment = .center
        
        return label ?? UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}

