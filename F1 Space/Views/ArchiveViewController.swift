//
//  ArchiveViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit


struct FakeModel {
    var year: Int

}

final class ArchiveViewController: UIViewController {

//    var yearPickerView = UIPickerView()

    
    let yearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("2020", for: .normal)
        return button
    }()
    
    let containerView  = ContainerPicker()
    
//    var yearCount = 71
//    var array = [Int]()
//
//    func getAllTheChampionshipYears() {
//        let date = Date()
//        let calendar = Calendar.current
//
//        let currentYear = calendar.component(.year, from: date) // here 2020
//
//        for i in 0...yearCount - 1 {
//            let year = currentYear - i
//            array.append(year)
//        }
////        print(array)
//    }
    
    // MARK: Public Methods
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        getAllTheChampionshipYears()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(yearButton)
        yearButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                          padding: .init(top: 100, left: 50, bottom: 0, right: 50),
                          size: .init(width: 0, height: 60))
        
        view.addSubview(containerView)
        containerView.anchor(top: yearButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                             padding: .init(top: 100, left: 50, bottom: 50, right: 50))
        
    }
    
//    @objc func monthdoneButtonAction() {
//        //  получаем текущее значение у пикера
//        let selectedRow = yearPickerView.selectedRow(inComponent: 0)
//        let desiredValue = array[selectedRow]
//        yearButton.setTitle(String(desiredValue), for: .normal)
//        print(desiredValue)
//    }
    
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return array.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(array[row])
//    }
}
