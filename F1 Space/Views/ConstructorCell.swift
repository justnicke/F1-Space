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
        label.font = UIFont(name: "Formula1-Display-Bold", size: 23)
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
    private let helperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9259110093, green: 0.9457291961, blue: 0.9495975375, alpha: 1)
        view.widthAnchor.constraint(equalToConstant: 90).isActive = true
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
    
    func configure(constructor: Constructor?) {
        positionLabel.text = constructor?.position
        teamColorView.backgroundColor = constructor?.teamColor
        teamNameLabel.text = constructor?.team
        numberPtsLabel.text = constructor?.pts
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        let teamViewsHelper = UIStackView(arrangedSubviews: [UIView(), teamColorView, UIView()], axis: .vertical)
        teamViewsHelper.distribution = .equalCentering
        
        let positionAndTeamColorStackView = UIStackView(arrangedSubviews: [positionLabel, teamViewsHelper],
                                                        axis: .horizontal,
                                                        spacing: 20)
        
//        let fullNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel],
//                                            axis: .horizontal,
//                                            spacing: 3)
        
        let fullNameAndTeamNameStackView = UIStackView(arrangedSubviews: [UIView(), teamNameLabel, UIView()],
                                                       axis: .vertical,
                                                       spacing: 10)
        fullNameAndTeamNameStackView.distribution = .equalCentering
        
        let numPtsAndPtsWordStackView = UIStackView(arrangedSubviews: [numberPtsLabel, ptsWordLabel],
                                                    axis: .horizontal,
                                                    spacing: 5)
        
        helperView.addSubview(numPtsAndPtsWordStackView)
        numPtsAndPtsWordStackView.centerInSuperview()
        
        let helperStackView = UIStackView(arrangedSubviews: [UIView(), helperView, UIView()], axis: .vertical)
        helperStackView.distribution = .equalCentering
        
        
        let allyStackView = UIStackView(arrangedSubviews: [fullNameAndTeamNameStackView, UIView(), helperStackView],
                                        axis: .horizontal)
        
        let stackview = UIStackView(arrangedSubviews: [positionAndTeamColorStackView, allyStackView], axis: .horizontal, spacing: 10)
        addSubview(stackview)
        stackview.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
}
