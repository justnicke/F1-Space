//
//  ArchiveCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 25.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class ArchiveCell: UITableViewCell {
    
    private let any1Label: UILabel = {
        let label = UILabel()
        label.text = "Pos"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .black
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    private let any2Label: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .black
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    private let any3Label: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .black
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    private let any4Label: UILabel = {
        let label = UILabel()
//        label.text = "Any Text"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .black
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    private let any5Label: UILabel = {
        let label = UILabel()
//        label.text = "Any Text"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .black
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI1()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI1() {
        
        addSubview(any1Label)
        any1Label.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 20, bottom: 5, right: 0)
        )
        
        addSubview(any2Label)
        any2Label.anchor(
            top: self.topAnchor,
            leading: any1Label.trailingAnchor,
            bottom: self.bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 20, bottom: 5, right: 0)
        )
        
        addSubview(any3Label)
        any3Label.anchor(
            top: self.topAnchor,
            leading: any2Label.trailingAnchor,
            bottom: self.bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 20, bottom: 5, right: 0)
        )
        
        if any4Label.text != nil {
            addSubview(any4Label)
            any4Label.anchor(
                top: self.topAnchor,
                leading: any3Label.trailingAnchor,
                bottom: self.bottomAnchor,
                trailing: nil,
                padding: .init(top: 5, left: 20, bottom: 5, right: 0)
            )
        }
        
        if any4Label.text != nil {
            addSubview(any5Label)
            any5Label.anchor(
                top: self.topAnchor,
                leading: any4Label.trailingAnchor,
                bottom: self.bottomAnchor,
                trailing: nil,
                padding: .init(top: 5, left: 20, bottom: 5, right: 0)
            )
        }
        
    }
    
    func congigure(anyType: AnyType?) {
        
    }
    
}

struct AnyType {
    var pos: String?
    var name: String?
    var time: String?
    var someValue1: String?
    var someValue2: String?
}
