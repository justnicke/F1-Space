//
//  HistoricalPickerView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

enum Countering: Int {
    case first  = 0
    case second = 1
    case third  = 2
}

final class PickerViewController: UIViewController {
    
    // MARK: - Public Properties
    
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
    private let handleDismissView = UIView()
    
    // MARK: - Private Nested
    
    var count = Countering(rawValue: .zero)
    
    var testArray: [String?] = []
    
    let pickerViewModel = PickerViewModel()
    
    // MARK: - Constructors
    
//    init(year: String, typeResult: String, listResults: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.first = year
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    deinit {
//        print("deinit PickerVC")
//    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupUI()
        updateViewModel()

        doneButton.addTarget(self, action: #selector(sendValueFromPicker), for: .touchUpInside)
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
    
    @objc func sendValueFromPicker() {
        let selectedRow = picker.selectedRow(inComponent: 0)
        
        dismiss(animated: true) {
            self.pickerViewModel.sendValueFromPicker(state: self.count!, selectedRow: selectedRow)
        }
    }
}

// Запросы и обновление
extension PickerViewController {
    
    func updateViewModel() {
        pickerViewModel.requestData(arr: testArray, state: count!) { [weak self] in
            
            self?.reloadData()
            
        }
    }
    
    private func reloadData() {
        picker.reloadAllComponents()
        initPicker()
        currentPickerValue()
    }
    
    private func currentPickerValue() {
        picker.selectRow(pickerViewModel.selectedRowPicker(arr: testArray, state: count!), inComponent: 0, animated: false)
    }
    

}

// MARK: - Extension UIPickerViewDataSource & UIPickerViewDelegate

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewModel.numberOfRowsIn(state: count!, component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewModel.titleFor(state: count!, row: row)
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
        
        let title = NSAttributedString()
        
        let a = pickerViewModel.viewFor(state: count!, row: row, for: title, and: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont()])
        
        label?.attributedText = a
        label?.textColor = #colorLiteral(red: 0.3819147944, green: 0.3267760873, blue: 0.8082862496, alpha: 1)
        label?.textAlignment = .center
        
        return label ?? UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
