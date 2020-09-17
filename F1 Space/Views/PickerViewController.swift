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
    
    var supportingValue: String!    // передается первый пикер с годом
    var supportingValue2: String?   // передается второй пикер
    var supportingValue3: String?   // передается первый пикер с годом
    var supportingValue4: String?   // передается второй пикер
    var supportingValue5: String?   // передается 3 пикер
    
//    var first: String?
//    var second: String?
//    var third: String?
    
    var counter: Int!
    
    weak var delegate: PickerTypeDelegate?
    
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
    private var pickerResult = PickerResult(yearCount: nil, championships: [])
    
    // MARK: - Private Nested
    
    private enum SelectedType: String {
        case drivers, teams, races
    }
    
    var count = Countering(rawValue: .zero)
    
    var testArray: [String?] = []

    var resultsID = ["All"] // убрать
    
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
        
//        print(counter!)
        setupUI()
        requestData()
        
//        switch count {
//        case .first:
//            print(count!.rawValue)
//            print(testArray)
//        case .second:
//            print(count!.rawValue)
//            print(testArray)
//        case .third:
//            print(count!.rawValue)
//            print(testArray)
//        case .none: break
//        }
        
        
//        if count == .some(.first) {
//            print(count!.rawValue)
//            print(testArray)
//        } else if count == .second {
//            print(count?.rawValue)
//            print(testArray)
//        } else if count == .tr {
//            print(count?.rawValue)
//            print(testArray)
//        }
        
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
    
    private func getChampionshipYear() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        if let string = pickerResult.yearCount, let convertedYearCount = Int(string) {
            for i in 0...convertedYearCount - 1 {
                let year = currentYear - i
                pickerResult.championships.append(year)
            }
        }
    }
  
    @objc private func sendValueFromPicker() {
        let selectedRow = picker.selectedRow(inComponent: 0)
        
        switch count {
        case .first:
            dismiss(animated: true) {
                let selectedValue = self.pickerResult.championships[selectedRow]
                self.delegate?.year(value: selectedValue)
            }
        case .second:
            dismiss(animated: true) {
                let selectedValue = self.pickerResult.typeResults[selectedRow]
                self.delegate?.type(result: selectedValue)
            }
        case .third:
            dismiss(animated: true) {
                let selectedValue = self.pickerResult.listResults[selectedRow]
                self.delegate?.result(value: selectedValue)
            }
        default: break
        }
    }
}

// Запросы и обновление
extension PickerViewController {
    
    private func reloadData() {
        picker.reloadAllComponents()
        initPicker()
        currentPickerValue()
    }
    
    private func currentPickerValue() {
        switch count {
        case .first:
            guard let year = Int(testArray[count?.rawValue ?? 0] ?? "2020") else { return }
            guard let index = pickerResult.championships.firstIndex(of: year) else { return }
            picker.selectRow(index, inComponent: 0, animated: false)
        case .second:
            guard let typeResult = testArray[0] else { return }
            guard let index = pickerResult.typeResults.firstIndex(of: typeResult) else { return }
            picker.selectRow(index, inComponent: 0, animated: false)
        case .third:
            guard let result = testArray[count?.rawValue ?? 0] else { return }
            guard let index = pickerResult.listResults.firstIndex(of: result) else { return }
            picker.selectRow(index, inComponent: 0, animated: false)
        default: break
        }
    }

    private func requestData() {
        switch count {
        case .first:
            requestSeason()
        case .second:
            initPicker()
            currentPickerValue()
        case .third:
            requestDriverTeamOrRaceData()
        default: break
        }
    }
    
    private func requestSeason() {
        API.requestYearChampionship { [weak self] (dates, error) in
            self?.pickerResult.yearCount = dates?.championship.yearsCount
            self?.getChampionshipYear()
            self?.reloadData()
        }
    }
    
    private func requestDriverTeamOrRaceData() {
        let type = testArray[count!.rawValue - 1]?.lowercased()
        guard let year = testArray[count!.rawValue - count!.rawValue] else { return }
        
        if type == SelectedType.drivers.rawValue {
            API.requestDriverStandings(year: year) { [weak self] (driver, error) in
                let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
                
                guard let driver = drivers?.reduce([], +).compactMap({ $0.driver.givenName + " " + $0.driver.familyName })
                    else {
                        return
                }
                guard let driversID = drivers?.reduce([], +).compactMap({ $0.driver.driverID  })
                    else {
                        return
                }
                
                self?.pickerResult.listResults += driver
                self?.resultsID += driversID
                
                self?.reloadData()
            }
        } else if type == SelectedType.teams.rawValue {
            API.requestConstructorStandings(year: year) { [weak self] (constructor, error) in
                let constructors = constructor?
                    .constructorData
                    .constructorStandingsTable
                    .constructorStandingsLists.compactMap { $0.constructorStandings }

                guard let constructorsName = constructors?.reduce([], +).compactMap({ $0.constructor.name })
                    else {
                        return
                }
                guard let constructorsID = constructors?.reduce([], +).compactMap({ $0.constructor.constructorId })
                    else {
                        return
                }

                self?.pickerResult.listResults += constructorsName
                self?.resultsID += constructorsID
                
                self?.reloadData()
            }
        } else {
            API.requestGrandPrix(year: year) { [weak self] (grandPrix, error) in
                guard let grandPrixes =  grandPrix?.mrData.raceTable.races.compactMap({ $0.raceName })
                    else {
                        return
                }
                guard let roundGP = grandPrix?.mrData.raceTable.races.compactMap({ $0.round })
                    else {
                        return
                }
                
                self?.pickerResult.listResults += grandPrixes
                self?.resultsID += roundGP
                
                self?.reloadData()
            }
        }
    }
}


// MARK: - Extension UIPickerViewDataSource & UIPickerViewDelegate

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch count {
        case .first:
            return pickerResult.championships.count
        case .second:
            return pickerResult.typeResults.count
        case .third:
            return pickerResult.listResults.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch count {
        case .first:
            return String(pickerResult.championships[row])
        case .second:
            return pickerResult.typeResults[row]
        case .third:
            return pickerResult.listResults[row]
        default:
            return ""
        }
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
        
        let title: NSAttributedString!
        
        switch count {
        case .first:
            title = NSAttributedString(
                string: String(pickerResult.championships[row]),
                attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont()]
            )
        case .second:
            title = NSAttributedString(
                string: pickerResult.typeResults[row],
                attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont()]
            )
        case .third:
            title = NSAttributedString(
                string: pickerResult.listResults[row],
                attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont()]
            )
        default:
            return UIView()
        }
        
        label?.attributedText = title
        label?.textColor = #colorLiteral(red: 0.3819147944, green: 0.3267760873, blue: 0.8082862496, alpha: 1)
        label?.textAlignment = .center
        
        return label ?? UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
