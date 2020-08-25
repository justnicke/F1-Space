//
//  ArchiveViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class ArchiveViewController: UITableViewController {
    
    let yearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("2020", for: .normal)
        return button
    }()
    let standingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        button.setTitle("Drivers", for: .normal)
        return button
    }()
    let variantResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.setTitle("All", for: .normal)
        return button
    }()
    let finalResultURLButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.setTitle("URL", for: .normal)
        return button
    }()
    var containerView: ContainerPicker!
    var standingContainer: StandingsContainerView!
    var containerViewNum3 = ContainerNum3()
    
    let headerView = UIView()
    
    var nameId: String?
//    var raceRound: String?
//    var resultStr: String!
    
    // MARK: Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(ArchiveCell.self, forCellReuseIdentifier: "cell")
        setupUI()
        
        yearButton.addTarget(self, action: #selector(actionYearButton), for: .touchUpInside)
        standingsButton.addTarget(self, action: #selector(actionStandingsButton), for: .touchUpInside)
        variantResultButton.addTarget(self, action: #selector(resultButton), for: .touchUpInside)
        finalResultURLButton.addTarget(self, action: #selector(handleURL), for: .touchUpInside)
    }
    
    // MARK: Prrivate Methods
    
    private func setupUI() {
        headerView.addSubview(yearButton)
        yearButton.anchor(
            top: headerView.topAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            padding: .init(top: 10, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 30)
        )
        
        headerView.addSubview(standingsButton)
        standingsButton.anchor(
            top: yearButton.bottomAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            padding: .init(top: 10, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 30)
        )
        
        headerView.addSubview(variantResultButton)
        variantResultButton.anchor(
            top: standingsButton.bottomAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            padding: .init(top: 10, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 30)
        )
        
        headerView.addSubview(finalResultURLButton)
        finalResultURLButton.anchor(
            top: variantResultButton.bottomAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            padding: .init(top: 10, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 30)
        )
        
        initialRequest()
    }
    
    private func requestData() {
        API.requestYearChampionship { [weak self] (years, error) in
            self?.containerView.yearsCount = years?.championship.yearsCount
        }
    }
    
    private func requestDataForPicker() {
         guard let year = yearButton.titleLabel?.text  else { return }
        
        if standingsButton.titleLabel?.text == "Drivers" {
            API.requestDriverStandings(year: year) { [weak self] (driver, error) in
                let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
                let convertedDrivers = drivers?.reduce([], +)
                
                let driver = convertedDrivers?.compactMap { $0.driver.givenName + " " + $0.driver.familyName }
                let driversID = convertedDrivers?.compactMap { $0.driver.driverID }
                
                guard let driversZ = driver else { return }
                guard let driversIDZ = driversID else { return }
                
                self?.containerViewNum3.results += driversZ
                self?.containerViewNum3.resultsID += driversIDZ
            }
        } else if standingsButton.titleLabel?.text == "Teams" {
            API.requestConstructorStandings(year: year) { [weak self] (constructor, error) in
                let constructors = constructor?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
                let convertedconstructors = constructors?.reduce([], +)
                
                let constructorsName = convertedconstructors?.compactMap { $0.constructor.name}
                let constructorsID = convertedconstructors?.compactMap { $0.constructor.constructorId }
                
                guard let constructorList = constructorsName else { return }
                guard let constID = constructorsID else { return }
                
                self?.containerViewNum3.results += constructorList
                self?.containerViewNum3.resultsID += constID
            }
        } else {
            API.requestGrandPrix(year: year) { [weak self] (grandPrix, error) in
                let grandPrixes =  grandPrix?.mrData.raceTable.races.compactMap { $0.raceName }
                let roundGP = grandPrix?.mrData.raceTable.races.compactMap { $0.round }
                
                guard let crucit = grandPrixes else { return }
                guard let round = roundGP else { return }
                
                self?.containerViewNum3.results += crucit
                self?.containerViewNum3.resultsID += round
            }
        }
    }
    
    @objc private func handleURL() {
        guard let year = yearButton.titleLabel?.text  else { return }
        guard var standings = standingsButton.titleLabel?.text  else { return }
        guard let result = variantResultButton.titleLabel?.text else { return }
        guard let currentID = nameId else { return }
        
        if standings == "Teams" {
            standings = "constructors"
            if result == "All" {
                print("https://ergast.com/api/f1/\(year)/constructorStandings.json")
            } else {
                print("https://ergast.com/api/f1/\(year)/\(standings)/\(currentID)/results.json?limit=60")
            }
        } else if standings == "Drivers" {
            if result == "All" {
                print("https://ergast.com/api/f1/\(year)/driverStandings.json")
            } else {
                print("https://ergast.com/api/f1/\(year)/\(standings)/\(currentID)/results.json")
            }
        } else {
            if result == "All" {
                print("https://ergast.com/api/f1/\(year)/results/1.json")
            } else {
                // Делаем только резулятат гонки и квалификации, после UI разберемся
                print("https://ergast.com/api/f1/\(year)/\(currentID)/results.json") // трасса, победитель, команда
            }
        }
    }
    
    // Запрос по умолчанию при запуске приложения
    private func initialRequest() {
        guard let year = yearButton.titleLabel?.text  else { return }
        guard let standings = standingsButton.titleLabel?.text?.lowercased()  else { return }
        print("https://ergast.com/api/f1/\(year)/\(standings.dropLast())Standings.json")
        
    }
    
    @objc private func actionYearButton() {
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
    
    @objc private func actionStandingsButton() {
        standingContainer = StandingsContainerView()
        view.addSubview(standingContainer)
        standingContainer.isHidden = false
        standingContainer.delegate = self
        standingContainer.translatesAutoresizingMaskIntoConstraints = false
        standingContainer.centerInSuperview(size: .init(width: view.frame.width - 40,
                                                        height: 200))
    }
    
    @objc private func resultButton() {
        containerViewNum3 = ContainerNum3()
        view.addSubview(containerViewNum3)
        containerViewNum3.isHidden = false
        containerViewNum3.delegate = self
        containerViewNum3.translatesAutoresizingMaskIntoConstraints = false
        containerViewNum3.centerInSuperview(size: .init(width: view.frame.width - 40,
                                                        height: 200))
        
        requestDataForPicker()
        containerViewNum3.initView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        headerView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArchiveCell
        
        cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ArchiveViewController: PassValueType {
    
    func picker2(value: String) {
        standingsButton.setTitle(value, for: .normal)
        standingContainer.isHidden = true
        variantResultButton.setTitle("All", for: .normal)
    }
    
    func picker(value: Int) {
        yearButton.setTitle(String(value), for: .normal)
        containerView.isHidden = true
        containerView.removeFromSuperview()
        yearButton.isEnabled = true
    }
    
    func picker3(value: String?, arrayStand: String) {
        nameId = value
        variantResultButton.setTitle(arrayStand, for: .normal)
        containerViewNum3.isHidden = true
    }
}
