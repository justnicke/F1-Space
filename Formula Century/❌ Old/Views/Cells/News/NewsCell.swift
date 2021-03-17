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
    
    static let reuseId = String(describing: NewsCell.self)
    
    // MARK: Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заголовок"
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
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
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleToFill
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return imageView
    }()
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9815699458, green: 0.9517598748, blue: 0.9695971608, alpha: 1)
        selectionStyle = .none
        setupContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
        
    func configure(viewModel: NewsCellViewModel?) {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        
        if let date = viewModel?.published {
            let components = Calendar.current.dateComponents([.minute, .hour, .day], from: date, to: Date())
            let agoString = "ago"
            
            if let days = components.day, days > 0 {
                dateLabel.text = "\(days) \(Formatter.days(for: days)) \(agoString)"
            } else if let hours = components.hour, hours > 0 {
                dateLabel.text = "\(hours) \(Formatter.hours(for: hours)) \(agoString)"
            } else if let minutes = components.minute, minutes > 0 {
                dateLabel.text = "\(minutes) \(Formatter.minutes(for: minutes)) \(agoString)"
            } else {
                dateLabel.text = nil
            }
        }
        
        if viewModel?.url.contains("motorsport.com") ?? false {
            logoImageView.image = #imageLiteral(resourceName: "motorsport.com")
        } else {
            logoImageView.image = #imageLiteral(resourceName: "f1news.ru")
        }
    }
    
    // MARK: - Private Methods
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 5, right: 10)
        )
        
        setupContents()
    }
    
    private func setupContents() {
        [logoImageView, titleLabel, descriptionLabel, dateLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        
        dateLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        dateLabel.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
}
