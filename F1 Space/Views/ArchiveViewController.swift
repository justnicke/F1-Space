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
    
    var yearStr: String!
    var standingsStr: String!
    var resultStr: String!
    
    // MARK: Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
        yearButton.addTarget(self, action: #selector(actionYearButton), for: .touchUpInside)
        standingsButton.addTarget(self, action: #selector(actionStandingsButton), for: .touchUpInside)
        variantResultButton.addTarget(self, action: #selector(resultButton), for: .touchUpInside)
        finalResultURLButton.addTarget(self, action: #selector(handleURL), for: .touchUpInside)
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
        
        view.addSubview(variantResultButton)
        variantResultButton.anchor(
            top: standingsButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 30, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 60)
        )
        
        view.addSubview(finalResultURLButton)
        finalResultURLButton.anchor(
            top: variantResultButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 30, left: 50, bottom: 0, right: 50),
            size: .init(width: 0, height: 60)
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
                guard let driversZ = driver else { return }
                self?.containerViewNum3.results += driversZ
            }
        } else if standingsButton.titleLabel?.text == "Teams" {
            API.requestConstructorStandings(year: year) { [weak self] (constructor, error) in
                let constructors = constructor?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
                let convertedconstructors = constructors?.reduce([], +)
                let driver = convertedconstructors?.compactMap { $0.constructor.name}
                guard let driversZ = driver else { return }
                self?.containerViewNum3.results += driversZ
            }
        } else {
            API.requestGrandPrix { [weak self] (grandPrix, error) in
                let grandPrixes =  grandPrix?.mrData.raceTable.races.compactMap { $0.raceName }
                guard let crucit = grandPrixes else { return }
                self?.containerViewNum3.results += crucit
            }
        }
    }
    
    @objc private func handleURL() {
        guard let year = yearButton.titleLabel?.text  else { return }
        guard var standings = standingsButton.titleLabel?.text  else { return }
        guard let result = variantResultButton.titleLabel?.text else { return }
        
        
//        print("https://ergast.com/api/f1/\(year)/drivers/\(result)/results")
        if standings == "Teams" {
            standings = "constructors"
            if result == "All" {
                print("https://ergast.com/api/f1/\(year)/constructorStandings.json")
            } else {
                let constructorsResult = result.replacingOccurrences(of: " ", with: "_")
                print("https://ergast.com/api/f1/\(year)/\(standings)/\(constructorsResult)/results.json?limit=60")
            }
        } else if standings == "Drivers" {
            if result == "All" {
                print("https://ergast.com/api/f1/\(year)/driverStandings.json")
            } else {
                /* Сделать исключение для гонщиков которые были с одинаковыми фамилиями тк просто по фамилии будет ошибка.
                 Пример: Verstappen будет ошибка тк в 90 гонял jos_Verstappen а сейчас max_Verstappen
                 Таких гонщиков возможно много (около 20 шт)
                 По пямяти (фитипальди, ферсапен, сенна, шумахер, росберг
                 
                 Или сделать проверку запроса если с имя фамилией нил то вернуть только фамилию, но проблема что запрос с именем сущетсвет токлько он пустой
)                 */
                
                guard let nameResult = result.components(separatedBy: " ").last else { return }
                
                guard let urlString = URL(string: "https://ergast.com/api/f1/\(year)/\(standings)/\(nameResult)/results.json") else { return print("Bad_URL")}
                URLSession.shared.dataTask(with: urlString) { (data, res, err) in
                    if let error = err {
                        print(error.localizedDescription)
                    }
                    
                    guard let data = data else { return print("Data was nil")}
//                    if data.copyBytes(to: <#T##UnsafeMutableBufferPointer<DestinationType>#>, from: <#T##Range<Data.Index>?#>)
                    print(data)
                    
                    
                    
                } .resume()
//                print(urlString!)
                print("https://ergast.com/api/f1/\(year)/\(standings)/\(nameResult)/results.json")
            }
        } else {
            
        }
        

           /* DRIVERS
               - https://ergast.com/api/f1/2008/driverStandings ALL
               - https://ergast.com/api/f1/2020/drivers/hamilton/results selected driver
            */
           
           /* TEAMS
               - https://ergast.com/api/f1/2020/constructorStandings.json ALL
            */
               
           /* Races
               - https://ergast.com/api/f1/2020/results/1 ALL
            */
        
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
    
    func picker3(value: String) {
        variantResultButton.setTitle(value, for: .normal)
        containerViewNum3.isHidden = true
    }
}
