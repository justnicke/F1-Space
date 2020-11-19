//
//  HistoricalPickerViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalPickerViewModel {
    
    // MARK: - Public Properties
    
    weak var delegate: HistoricalPickerSelectedDelegate?
    
    // MARK: - Private Properties
    
    var pickerResult = HistoricalPickerResult(totalSeasons: nil,
                                                      championships: [],
                                                      detailedResult: ["All"],
                                                      detailedResultID: ["All"])
    
    var currentValues: [String?]
    var state: HistoricalPickerSelected?
    
    // MARK: - Constructors
    
    init(currentValues: [String?], by state: HistoricalPickerSelected?) {
        self.currentValues = currentValues
        self.state = state
    }
    
    // MARK: - Public Methods
    
    func sendValueFromPicker(row: Int) {
        switch state {
        case .yearChampionship:
            let selectedValue = pickerResult.championships[row]
            delegate?.year(currentСhampionship: selectedValue)
        case .category:
            let selectedСategory = pickerResult.category[row]
            delegate?.category(current: selectedСategory)
        case .detailedResult:
            let selectedValue = pickerResult.detailedResult[row]
            let selectedID = pickerResult.detailedResultID[row]
            delegate?.detailed(currentResult: selectedValue, id: selectedID)
        default: fatalError("Не должно быть!")
        }
    }
    
    func selectedRowPicker() -> Array<Int>.Index {
        switch self.state {
        case .yearChampionship:
            if let year = currentValues[state.unwrap.rawValue],
               let index = pickerResult.championships.firstIndex(of: year) {
                return index
            }
        case .category:
            if let category = currentValues[0],
               let index = pickerResult.category.firstIndex(of: category) {
                return index
            }
        case .detailedResult:
            if let result = currentValues[self.state!.rawValue - 1],
               let index = pickerResult.detailedResult.firstIndex(of: result) {
                return index
            }
        default: return 0
        }
        return 0
    }
    
    let detailIndex = 1
    let categoryIndex = 2
    
    // запротоколирован
    func requestForSelection(completion: @escaping () -> (Void)) {
        switch self.state {
        case .yearChampionship:
            requestSeason(completion: completion)
        case .category:
            completion()
        case .detailedResult:
            selectedRequest(completion: completion)
        default: fatalError("Не должно быть!")
        }
    }
    
    // MARK: - Private Methods
    
    private func requestSeason(completion: @escaping () -> (Void)) {
        guard let category = currentValues[HIndex.category.rawValue]?.lowercased() else { return }
        
        if category == HistoricalCategory.drivers.rawValue {
            requestYearDataForDriver(completion: completion)
        } else if category == HistoricalCategory.teams.rawValue {
            requestYearDataForConstructor(completion: completion)
        } else {
            requestYearDataForRace(completion: completion)
        }
    }
}

// MARK: - Extension PickerViewModelType

extension HistoricalPickerViewModel: PickerViewModelType {
    
    func numberOfRowsInComponent(_ component: Int, by state: HistoricalPickerSelected) -> Int {
        switch self.state {
        case .yearChampionship:
            return pickerResult.championships.count
        case .category:
            return pickerResult.category.count
        case .detailedResult:
            return pickerResult.detailedResult.count
        default: fatalError("Не должно быть!")
        }
    }
    
    func titleForRow(_ row: Int, by state: HistoricalPickerSelected) -> String? {
        switch self.state {
        case .yearChampionship:
            return String(pickerResult.championships[row])
        case .category:
            return pickerResult.category[row]
        case .detailedResult:
            return pickerResult.detailedResult[row]
        default: fatalError("Не должно быть!")
        }
    }
    
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any], by state: HistoricalPickerSelected) -> NSAttributedString {
        var title = title
        
        switch self.state {
        case .yearChampionship:
            title = NSAttributedString(string: String(pickerResult.championships[row]), attributes: attributes)
            return title
        case .category:
            title = NSAttributedString(string: pickerResult.category[row], attributes: attributes)
            return title
        case .detailedResult:
            title = NSAttributedString(string: pickerResult.detailedResult[row], attributes: attributes)
            return title
        default: fatalError("Не должно быть!")
        }
    }
}
