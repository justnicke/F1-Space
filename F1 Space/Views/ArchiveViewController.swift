//
//  ArchiveViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class ArchiveViewController: UIViewController {
    
    let yearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("2020", for: .normal)
        return button
    }()
    let standingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        button.setTitle("Race", for: .normal)
        return button
    }()
    var containerView: ContainerPicker!
    var standingContainer: StandingsContainerView!
    
    // MARK: Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
        yearButton.addTarget(self, action: #selector(actionYearButton(sender:)), for: .touchUpInside)
        standingsButton.addTarget(self, action: #selector(actionStandingsButton(sender:)), for: .touchUpInside)
    }
    
    // MARK: Prrivate Methods
    
    private func setupUI() {
        view.addSubview(yearButton)
        yearButton.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 100, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 60)
        )
        
        view.addSubview(standingsButton)
        standingsButton.anchor(
            top: yearButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 30, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 60)
        )
    }
    
    private func requestData() {
        API.requestYearChampionship { [weak self] (years, error) in
            self?.containerView.yearsCount = years?.championship.yearsCount
        }
    }
    
    @objc private func actionYearButton(sender: UIButton) {
        // в будущем передалать
        containerView = ContainerPicker()
        view.addSubview(containerView)
        containerView.isHidden = false
        containerView.delegate = self
        containerView.centerInSuperview(size: .init(width: view.frame.width - 40,
                                                    height: 200))
        requestData()
        
        /* По нажатию на кнопку выбора года, перед тем, как открыть требуется:
         - Обработать Error в запросе
         - Проверить соединение с интернетом
         - В случае ошибок уведомить алертом
         - Появление контейнера + инициализация пикера
         - Пока контейнер пикера открыт кнопки выбора пикера отключены
         - По нажатию за пределами контейнера, скрыть контейнер и не применять изменения (Работа с тачем)
         - По нажатию на кнопку "Done" закрывать контейнер
         - Показывать следующи кнопки с выбором контенера исходя из выбранного года и вида (гонщик, конка или команда)
         */
        
        containerView.initView()
        yearButton.isEnabled = false
    }
    
    @objc private func actionStandingsButton(sender: UIButton) {
        standingContainer = StandingsContainerView()
        view.addSubview(standingContainer)
        standingContainer.isHidden = false
        standingContainer.delegate = self
        standingContainer.translatesAutoresizingMaskIntoConstraints = false
        standingContainer.centerInSuperview(size: .init(width: view.frame.width - 40,
                                                        height: 200))
        
    }
}

extension ArchiveViewController: PassValueType {
    func picker2(value: String) {
        standingsButton.setTitle(value, for: .normal)
        standingContainer.isHidden = true
    }
    
    func picker(value: Int) {
        yearButton.setTitle(String(value), for: .normal)
        containerView.isHidden = true
        containerView.removeFromSuperview()
        yearButton.isEnabled = true
    }
}
