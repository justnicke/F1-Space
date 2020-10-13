//
//  HistoricalStandingsHeader.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct HistoricalStandingsHeader {
    
    var firstHead:  String?
    var secondHead: String?
    var thirdHead:  String?
    var fourthHead: String?
    var fifthHead:  String?
    var sixthHead:  String?
    
    /// For the three headers (minimum)
    /// - Parameter firstHead:  equel firstLabel
    /// - Parameter secondHead: equel secondLabel
    /// - Parameter thirdHead:  equel thirdLabel
    init(_ firstHead: String, _ secondHead: String, _ thirdHead: String) {
        self.firstHead  = firstHead
        self.secondHead = secondHead
        self.thirdHead  = thirdHead
    }
    
    /// For the four headers
    /// - Parameter firstHead:  equel firstLabel
    /// - Parameter secondHead: equel secondLabel
    /// - Parameter thirdHead:  equel thirdLabel
    /// - Parameter fourthHead: equel fourthLabel
    init(_ firstHead: String, _ secondHead: String, _ thirdHead: String, _ fourthHead: String) {
        self.firstHead  = firstHead
        self.secondHead = secondHead
        self.thirdHead  = thirdHead
        self.fourthHead = fourthHead
    }
    
    /// For the five headers
    /// - Parameter firstHead:  equel firstLabel
    /// - Parameter secondHead: equel secondLabel
    /// - Parameter thirdHead:  equel thirdLabel
    /// - Parameter fourthHead: equel fourthLabel
    /// - Parameter fifthHead:  equel fifthLabel
    init(_ firstHead: String, _ secondHead: String, _ thirdHead: String, _ fourthHead: String, _ fifthHead: String) {
        self.firstHead  = firstHead
        self.secondHead = secondHead
        self.thirdHead  = thirdHead
        self.fourthHead = fourthHead
        self.fifthHead  = fifthHead
    }
    
    /// For the six headers (maximum)
    /// - Parameter firstHead:  equel firstLabel
    /// - Parameter secondHead: equel secondLabel
    /// - Parameter thirdHead:  equel thirdLabel
    /// - Parameter fourthHead: equel fourthLabel
    /// - Parameter fifthHead:  equel fifthLabel
    /// - Parameter sixthHead:  equel sixthLabel
    init(_ firstHead: String, _ secondHead: String, _ thirdHead: String, _ fourthHead: String, _ fifthHead: String, _ sixthHead: String) {
        self.firstHead  = firstHead
        self.secondHead = secondHead
        self.thirdHead  = thirdHead
        self.fourthHead = fourthHead
        self.fifthHead  = fifthHead
        self.sixthHead  = sixthHead
    }
}
