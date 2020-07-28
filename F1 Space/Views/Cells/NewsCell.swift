//
//  NewsCell.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 28.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    // MARK: Public Properties
    
    static let reusId = String(describing: NewsCell.self)
    
    // MARK: Private Properties
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заголовок Заголовок Заголовок Заголовок Заголовок Заголовок Заголовок"
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание Описание"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2 hours ago"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return imageView
    }()
    
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9815699458, green: 0.9517598748, blue: 0.9695971608, alpha: 1)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Public Methods
    
     // MARK: - Private Methods
    
    private func setupView() {
        addSubview(cellView)
        cellView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,
                        padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        setupContents()
    }
    
    private func setupContents() {
        [logoImageView, titleLabel, descriptionLabel, dateLabel].forEach {
            cellView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true

        titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15).isActive = true
    }
}
