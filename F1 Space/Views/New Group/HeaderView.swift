//
//  HeaderView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 27.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

//final class HeaderView: UIView {
//    
//    private let oneLabel: UILabel = {
//        let label = UILabel()
////        label.text = "POS"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    private let twoLabel: UILabel = {
//        let label = UILabel()
////        label.text = "DRIVER"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    private let threeLabel: UILabel = {
//        let label = UILabel()
////        label.text = "NATIONALITY"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    private let fourLabel: UILabel = {
//        let label = UILabel()
////        label.text = "CAR"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    private let fiveLabel: UILabel = {
//        let label = UILabel()
////        label.text = "PTS"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let behindView = UIView()
//    private let behindView2 = UIView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureHeader1() {
//        oneLabel.text = "POS"
//        twoLabel.text = "DRIVER"
//        threeLabel.text = "NATIONALITY"
//        fourLabel.text = "CAR"
//        fiveLabel.text = "PTS"
//        
//        setupUI2().removeFromSuperview()
//        _ = setupUI()
//    }
//    
//    func configureHeader2() {
//        oneLabel.text = "POS"
//        twoLabel.text = "DRIVER"
//        threeLabel.text = "NATIONALITY"
//        
//        setupUI().removeFromSuperview()
//        _ = setupUI2()
//    }
//    
//    
//    func setupUI() -> UIView {
//        addSubview(behindView)
//        behindView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
//        
//        [oneLabel, twoLabel, threeLabel, fourLabel, fiveLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            behindView.addSubview($0)
//        }
//        
//        oneLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//        oneLabel.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
//        oneLabel.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
//        oneLabel.leadingAnchor.constraint(equalTo: behindView.leadingAnchor).isActive = true
//        oneLabel.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.1).isActive = true
//        
//        twoLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
//        twoLabel.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
//        twoLabel.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
//        twoLabel.leadingAnchor.constraint(equalTo: oneLabel.trailingAnchor).isActive = true
//        twoLabel.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
//        
//        threeLabel.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
//        threeLabel.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
//        threeLabel.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
//        threeLabel.leadingAnchor.constraint(equalTo: twoLabel.trailingAnchor).isActive = true
//        threeLabel.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
//        
//        fourLabel.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        fourLabel.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
//        fourLabel.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
//        fourLabel.leadingAnchor.constraint(equalTo: threeLabel.trailingAnchor).isActive = true
//        fourLabel.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.25).isActive = true
//        
//        fiveLabel.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//        fiveLabel.topAnchor.constraint(equalTo: behindView.topAnchor).isActive = true
//        fiveLabel.bottomAnchor.constraint(equalTo: behindView.bottomAnchor).isActive = true
//        fiveLabel.leadingAnchor.constraint(equalTo: fourLabel.trailingAnchor).isActive = true
//        fiveLabel.widthAnchor.constraint(equalTo: behindView.widthAnchor, multiplier: 0.15).isActive = true
//        
//        return behindView
//    }
//    
//    func setupUI2() -> UIView {
//        addSubview(behindView2)
//        behindView2.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
//        
//        [oneLabel, twoLabel, threeLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            behindView2.addSubview($0)
//        }
//        
//        oneLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//        oneLabel.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
//        oneLabel.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
//        oneLabel.leadingAnchor.constraint(equalTo: behindView2.leadingAnchor).isActive = true
//        oneLabel.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.1).isActive = true
//        
//        twoLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
//        twoLabel.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
//        twoLabel.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
//        twoLabel.leadingAnchor.constraint(equalTo: oneLabel.trailingAnchor).isActive = true
//        twoLabel.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.25).isActive = true
//        
//        threeLabel.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
//        threeLabel.topAnchor.constraint(equalTo: behindView2.topAnchor).isActive = true
//        threeLabel.bottomAnchor.constraint(equalTo: behindView2.bottomAnchor).isActive = true
//        threeLabel.leadingAnchor.constraint(equalTo: twoLabel.trailingAnchor).isActive = true
//        threeLabel.widthAnchor.constraint(equalTo: behindView2.widthAnchor, multiplier: 0.25).isActive = true
//        
//        return behindView2
//    }
//}
