//
//  ConstructorCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 09.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class ConstructorCell: UICollectionViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: ConstructorCell.self)
    
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
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "NORRIS"
        label.font = UIFont(name: "Formula1-Display-Bold", size: 18)
        label.textColor = .black
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
    
    func configureViewModel(cellViewModel: ConstructorCellViewModel?) {
        positionLabel.text = cellViewModel?.position
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
        let teamName = UIStackView(
            arrangedSubviews: [UIView(), teamNameLabel, UIView()],
            axis: .vertical,
            spacing: 10,
            distribution: .equalCentering
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
        let mergeTeamNameAndRoundingPtsStackView = UIStackView(
            arrangedSubviews: [teamName, UIView(), roundingPtsStackView],
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
            size: .init(width: 45, height: 0)
        )
        
        roundingPtsView.addSubview(ptsNumAndWord)
        ptsNumAndWord.centerInSuperview()
        
        addSubview(mergeTeamNameAndRoundingPtsStackView)
        mergeTeamNameAndRoundingPtsStackView.anchor(
            top: topAnchor,
            leading: positionLabelAndTeamColor.trailingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 5, left: 10, bottom: 5, right: 20)
        )
    }
}
