//
//  ContainerPicker.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

//protocol PassValueType: class {
//    func picker(value: Int)
//    func picker2(value: String)
//    func picker3(value: String?, arrayStand: String)
//}
//
//final class ContainerPicker: UIView {
//    
//    var picker = UIPickerView()
//    var doneButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Done", for: .normal)
//        button.backgroundColor = .red
//        return button
//    }()
//    var yearsCount: String? // это значение получить из сетевых данных
//    var championships = [Int]()
//    weak var delegate: PassValueType?
//    
//    // MARK: - Constructors
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        
//        doneButton.addTarget(self, action: #selector(getValueFromPicker), for: .touchUpInside)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func initView() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//            self.setupUI()
//            self.getChampionshipYears()
//        }
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
//    private func getChampionshipYears() {
//        let date = Date()
//        let calendar = Calendar.current
//        let currentYear = calendar.component(.year, from: date)
//        
//        if let string = yearsCount, let convertedYearCount = Int(string) {
//            for i in 0...convertedYearCount - 1 {
//                let year = currentYear - i
//                championships.append(year)
//            }
//        }
//    }
//    
//    @objc private func getValueFromPicker() {
//        //  получаем текущее значение у пикера
//        let selectedRow = picker.selectedRow(inComponent: 0)
//        let selectedValue = championships[selectedRow]
//        
//        delegate?.picker(value: selectedValue)
//    }
//}
//
//// MARK: - Extension CollectionViewDataSource & CollectionViewDelegate
//
//extension ContainerPicker: UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return championships.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(championships[row])
//    }
//}
//
//
