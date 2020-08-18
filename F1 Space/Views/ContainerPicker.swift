//
//  ContainerPicker.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class ContainerPicker: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var yearPickerView = UIPickerView()
    
    var yearCount = 71
    var array = [Int]()
        
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        yearPickerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(yearPickerView)
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        yearPickerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        yearPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        yearPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAllTheChampionshipYears() {
        let date = Date()
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: date) // here 2020
        
        for i in 0...yearCount - 1 {
            let year = currentYear - i
            array.append(year)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(array[row])
    }
}
