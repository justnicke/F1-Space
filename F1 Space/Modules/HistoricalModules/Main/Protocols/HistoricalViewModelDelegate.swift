//
//  HistoricalViewModelDelegate.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalViewModelDelegate {
    associatedtype DetailViewModel
    func heightForRow() -> Int
    func viewForHeader() -> HistoricalHeaderViewModel?
    func heightForHeader() -> Int
    func didSelectRowAt(indexPath: IndexPath) -> DetailViewModel
}
