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
//    func type(result: String)
}

final class PickerViewController: UIViewController {
    
    // MARK: - Public Properties
    var yearString: String!
    
    weak var delegate: PickerType?
    
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
    private var championships = [Int]()
    private var typeResults = ["Drivers", "Teams", "Races"]
    private var yearCount: String?
    
   
    deinit {
        print("deinit PickerVC")
    }
    
    // MARK: - Public Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        requestDates()
        setupUI()
        
        doneButton.addTarget(self, action: #selector(sendValueFromPicker), for: .touchUpInside)
//        doneButton.addTarget(self, action: #selector(getValueFromPicker2), for: .touchUpInside)
//        doneButton.addTarget(self, action: #selector(getValueFromPicker3), for: .touchUpInside)
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
    
    private func requestDates() {
        API.requestYearChampionship { [weak self] (dates, error) in
            self?.yearCount = dates?.championship.yearsCount
            self?.getChampionshipYear()
            self?.updatePickerValue()
            self?.picker.reloadAllComponents()
        }
    }
    
    private func updatePickerValue() {
        guard let year = Int(yearString) else { return }
        guard let index = championships.firstIndex(of: year) else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.picker.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
//    private func requestDataForPicker() {
//        guard let year = yearButton.titleLabel?.text  else { return }
//
//        if standingsButton.titleLabel?.text == "Drivers" {
//            API.requestDriverStandings(year: year) { [weak self] (driver, error) in
//                let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
//                let convertedDrivers = drivers?.reduce([], +)
//
//                let driver = convertedDrivers?.compactMap { $0.driver.givenName + " " + $0.driver.familyName }
//                let driversID = convertedDrivers?.compactMap { $0.driver.driverID }
//
//                guard let driversZ = driver else { return }
//                guard let driversIDZ = driversID else { return }
//
//                self?.containerViewNum3.results += driversZ
//                self?.containerViewNum3.resultsID += driversIDZ
//            }
//        } else if standingsButton.titleLabel?.text == "Teams" {
//            API.requestConstructorStandings(year: year) { [weak self] (constructor, error) in
//                let constructors = constructor?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
//                let convertedconstructors = constructors?.reduce([], +)
//
//                let constructorsName = convertedconstructors?.compactMap { $0.constructor.name}
//                let constructorsID = convertedconstructors?.compactMap { $0.constructor.constructorId }
//
//                guard let constructorList = constructorsName else { return }
//                guard let constID = constructorsID else { return }
//
//                self?.containerViewNum3.results += constructorList
//                self?.containerViewNum3.resultsID += constID
//            }
//        } else {
//            API.requestGrandPrix(year: year) { [weak self] (grandPrix, error) in
//                let grandPrixes =  grandPrix?.mrData.raceTable.races.compactMap { $0.raceName }
//                let roundGP = grandPrix?.mrData.raceTable.races.compactMap { $0.round }
//
//                guard let crucit = grandPrixes else { return }
//                guard let round = roundGP else { return }
//
//                self?.containerViewNum3.results += crucit
//                self?.containerViewNum3.resultsID += round
//            }
//        }
//    }
    
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
    
    @objc private func sendValueFromPicker() {
        self.dismiss(animated: true) {
            let selectedRow = self.picker.selectedRow(inComponent: 0)
            let selectedValue = self.championships[selectedRow]
            self.delegate?.year(value: selectedValue)
        }
    }
    
//    @objc private func getValueFromPicker2() {
//        self.dismiss(animated: true) {
//            let selectedRow = self.picker.selectedRow(inComponent: 0)
//            let selectedValue = self.typeResults[selectedRow]
//
//            self.delegate?.type(result: selectedValue)
//        }
//    }
//    @objc private func getValueFromPicker3() {
//        self.dismiss(animated: true) {
//
//        }
//    }
}

// MARK: - Extension UIPickerViewDataSource & UIPickerViewDelegate

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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

