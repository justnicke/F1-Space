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
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any3Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any4Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    private let any5Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    
    private let behindView = UIView()
    private let behindView2 = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI1() -> UIView {
        addSubview(behindView2)
        behindView2.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        [any1Label, any2Label, any3Label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            behindView2.addSubview($0)
            $0.textAlignment = . center
            $0.backgroundColor = .black
        }
        
        any1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        any1Label.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
        any1Label.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
        any1Label.leadingAnchor.constraint(equalTo: behindView2.leadingAnchor).isActive = true
        any1Label.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.10).isActive = true
        
        any2Label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        any2Label.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
        any2Label.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
        any2Label.leadingAnchor.constraint(equalTo: any1Label.trailingAnchor).isActive = true
        any2Label.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.25).isActive = true
        
        any3Label.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        any3Label.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
        any3Label.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
        any3Label.leadingAnchor.constraint(equalTo: any2Label.trailingAnchor).isActive = true
        any3Label.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.25).isActive = true
        
        return behindView2
    }
    
    private func setupUI3() -> UIView{
        addSubview(behindView)
        behindView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        [any1Label, any2Label, any3Label, any4Label, any5Label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            behindView.addSubview($0)
            $0.textAlignment = . center
            $0.backgroundColor = .black
        }
        
        any1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        any1Label.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
        any1Label.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
        any1Label.leadingAnchor.constraint(equalTo: behindView.leadingAnchor).isActive = true
        any1Label.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.10).isActive = true
        
        any2Label.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        any2Label.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
        any2Label.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
        any2Label.leadingAnchor.constraint(equalTo: any1Label.trailingAnchor).isActive = true
        any2Label.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
        
        any3Label.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        any3Label.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
        any3Label.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
        any3Label.leadingAnchor.constraint(equalTo: any2Label.trailingAnchor).isActive = true
        any3Label.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
        
        any4Label.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        any4Label.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
        any4Label.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
        any4Label.leadingAnchor.constraint(equalTo: any3Label.trailingAnchor).isActive = true
        any4Label.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
        
        any5Label.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        any5Label.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
        any5Label.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
        any5Label.leadingAnchor.constraint(equalTo: any4Label.trailingAnchor).isActive = true
        any5Label.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.15).isActive = true
        
        return behindView
    }
    
    func congigure(anyType: DriverStandings?) {
        any1Label.text = anyType?.position
        any2Label.text = anyType?.driver.familyName.uppercased()
        any3Label.text = anyType?.driver.nationality
        any4Label.text = anyType?.team.first?.name.uppercased()
        any5Label.text = anyType?.points
        
        setupUI1().removeFromSuperview()
        _ = setupUI3()
        
    }
    
    func congigure2(anyType: DriverStandings?) {
        any1Label.text = anyType?.position
        any2Label.text = anyType?.driver.familyName
        any3Label.text = anyType?.team.first?.name
        
        setupUI3().removeFromSuperview()
        _ = setupUI1()
    }
    
}
