//
//  DriversCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//


import UIKit

final class DriversCell: UICollectionViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: DriversCell.self)
    
    // MARK: Private Properties
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "44"
        label.font = UIFont(name: "Formula1-Display-Bold", size: 23)
        label.textColor = .black
        return label
    }()
    private let teamColorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8249400258, blue: 0.7488506436, alpha: 1)
        view.widthAnchor.constraint(equalToConstant: 5).isActive = true
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    private let firstNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Lando"
        label.font = UIFont(name: "Formula1-Display-Regular", size: 22)
        label.textColor = .black
        return label
    }()
    private let lastNameLabel: UILabel = {
       let label = UILabel()
        label.text = "NORRIS"
        label.font = UIFont(name: "Formula1-Display-Bold", size: 22)
        label.textColor = .black
        return label
    }()
    private let teamNameLabel: UILabel = {
       let label = UILabel()
        label.text = "McLaren"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = #colorLiteral(red: 0.3976586461, green: 0.411819607, blue: 0.4419828057, alpha: 1)
        return label
    }()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(driver: Driver) {
        positionLabel.text = driver.position
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        let positionAndTeamColorStackView = UIStackView(arrangedSubviews: [positionLabel, teamColorView],
                                                        axis: .horizontal,
                                                        spacing: 10)
        addSubview(positionAndTeamColorStackView)
        
        let fullNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel],
                                            axis: .horizontal,
                                            spacing: 3)
        
        let fullNameAndTeamNameStackView = UIStackView(arrangedSubviews: [fullNameStackView, teamNameLabel],
                                                       axis: .vertical,
                                                       spacing: 12)
         addSubview(fullNameAndTeamNameStackView)
        
        fullNameAndTeamNameStackView.centerInSuperview()
//        positionAndTeamColorStackView.centerInSuperview()
    }
    

}

// FontName

//Formula1
//== Formula1-Display-Bold
//== Formula1-Display-Regular
//== Formula1-Display-Wide
//== Formula1-Display-Black
//Formula1
//== Formula1-Display-Bold
//== Formula1-Display-Regular
//== Formula1-Display-Wide
//== Formula1-Display-Black
//Formula1
//== Formula1-Display-Bold
//== Formula1-Display-Regular
//== Formula1-Display-Wide
//== Formula1-Display-Black
//Formula1
//== Formula1-Display-Bold
//== Formula1-Display-Regular
//== Formula1-Display-Wide
//== Formula1-Display-Black
