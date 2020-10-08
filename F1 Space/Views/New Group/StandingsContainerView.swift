//
//  StandingsContainerView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

//final class StandingsContainerView: UIView {
//    
//    var picker = UIPickerView()
//    var doneButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Done", for: .normal)
//        button.backgroundColor = .red
//        return button
//    }()
//    var standings = ["Drivers", "Teams", "Races"]
//    weak var delegate: PassValueType?
//    
//    // MARK: - Constructors
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        
//        setupUI()
//        
//        doneButton.addTarget(self, action: #selector(getValueFromPicker), for: .touchUpInside)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        addSubview(doneButton)
//        doneButton.anchor(
//            top: self.topAnchor,
//            leading: self.leadingAnchor,
//            bottom: nil,
//            trailing: self.trailingAnchor,
//            size: .init(width: 0, height: 50)
//        )
//        
//        addSubview(picker)
//        picker.anchor(
//            top: doneButton.bottomAnchor,
//            leading: self.leadingAnchor,
//            bottom: nil,
//            trailing: self.trailingAnchor,
//            size: .init(width: 0, height: 150)
//        )
//        picker.delegate = self
//        picker.dataSource = self
//    }
//    
//    @objc private func getValueFromPicker() {
//        //  получаем текущее значение у пикера
//        let selectedRow = picker.selectedRow(inComponent: 0)
//        let selectedValue = standings[selectedRow]
//        
//        delegate?.picker2(value: selectedValue)
//    }
//}
//
//// MARK: - Extension CollectionViewDataSource & CollectionViewDelegate
//
//extension StandingsContainerView: UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return standings.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return standings[row]
//    }
//}
