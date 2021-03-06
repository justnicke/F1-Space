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
    
    static let reuseId = String(describing: DriversCell.self)
    
    // MARK: Private Properties
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "44"
        label.font = UIFont(name: "Formula1-Display-Bold", size: 19)
        label.textColor = .black
        return label
    }()
    private let teamColorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8249400258, blue: 0.7488506436, alpha: 1)
        view.widthAnchor.constraint(equalToConstant: 5).isActive = true
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return view
    }()
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lando" 
        label.font = UIFont(name: "Formula1-Display-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "NORRIS"
        label.font = UIFont(name: "Formula1-Display-Bold", size: 16)
        label.textColor = .black
        return label
    }()
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "McLaren"
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = #colorLiteral(red: 0.3976586461, green: 0.411819607, blue: 0.4419828057, alpha: 1)
        return label
    }()
    private let roundingPtsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9259110093, green: 0.9457291961, blue: 0.9495975375, alpha: 1)
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.layer.cornerRadius =  15
        return view
    }()
    private let numberPtsLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.textColor = .black
        return label
    }()
    private let ptsWordLabel: UILabel = {
        let label = UILabel()
        label.text = "PTS"
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureViewModel(cellViewModel: DriverCellViewModel?) {
        positionLabel.text = cellViewModel?.position
        firstNameLabel.text = cellViewModel?.firstName
        lastNameLabel.text = cellViewModel?.lastName
        teamNameLabel.text = cellViewModel?.teamName
        numberPtsLabel.text = cellViewModel?.numberPts
        teamColorView.backgroundColor = ConstructorsColor.teamColor(constructor: cellViewModel?.teamName)
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        let teamColor = UIStackView(
            arrangedSubviews: [UIView(), teamColorView, UIView()],
            axis: .vertical,
            distribution: .equalCentering
        )
        let fullNameLabels = UIStackView(
            arrangedSubviews: [firstNameLabel, lastNameLabel],
            axis: .horizontal,
            spacing: 3
        )
        let fullNameAndTeamNameLabel = UIStackView(
            arrangedSubviews: [UIView(), fullNameLabels, teamNameLabel, UIView()],
            axis: .vertical,
            spacing: 10
        )
        let ptsNumAndWord = UIStackView(
            arrangedSubviews: [numberPtsLabel, ptsWordLabel],
            axis: .horizontal,
            spacing: 5
        )
        let roundingPtsStackView = UIStackView(
            arrangedSubviews: [UIView(), roundingPtsView, UIView()],
            axis: .vertical,
            distribution: .equalCentering
        )
        let mergeFullNameAndTeamNameLabelAndRoundingPtsStackView = UIStackView(
            arrangedSubviews: [fullNameAndTeamNameLabel, UIView(), roundingPtsStackView],
            axis: .horizontal
        )
        let positionLabelAndTeamColor = UIStackView(
            arrangedSubviews: [positionLabel, teamColor],
            axis: .horizontal,
            spacing: 5,
            distribution: .equalCentering
        )
        
        addSubview(positionLabelAndTeamColor)
        positionLabelAndTeamColor.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 5, left: 20, bottom: 5, right: 0),
            size: . init(width: 45, height: 0)
        )
        
        roundingPtsView.addSubview(ptsNumAndWord)
        ptsNumAndWord.centerInSuperview()
        
        addSubview(mergeFullNameAndTeamNameLabelAndRoundingPtsStackView)
        mergeFullNameAndTeamNameLabelAndRoundingPtsStackView.anchor(
            top: topAnchor,
            leading: positionLabelAndTeamColor.trailingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 5, left: 10, bottom: 5, right: 20)
        )
    }
}

