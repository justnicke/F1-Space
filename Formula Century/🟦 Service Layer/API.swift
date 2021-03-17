//
//  API.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class API {
    
    // MARK: - Private Nested
    
    enum EndPoint {
        case driverStandings(year: String)
        case constructorStandings(year: String)
        case season
        case firstPlaceResultInSeason(year: String)
        case driverDetail(year: String, id: String)
        case driverParticipated(id: String)
        case currentDriverStandings
        case constructorDetail(year: String, id: String)
        case constructorParticipated(id: String)
        case currentConstructorStandings
        /// Ferrari since the Foundation of Formula 1. So we take its API by Ferrari
        case seasonsOfficialConstructorsCup
        case concreteRaceResults(year: String, roundId: String)
        
        var urlComponents: URLComponents? {
            switch self {
            case .driverStandings(let year):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/driverStandings.json")
            case .constructorStandings(let year):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/constructorStandings.json")
            case .season:
                return
                    URLComponents(string: "https://ergast.com/api/f1/seasons.json")
            case .firstPlaceResultInSeason(let year):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/results/1.json")
            case .driverDetail(let year, let id):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/drivers/\(id)/results.json")
            case .driverParticipated(let id):
                return
                    URLComponents(string: "https://ergast.com/api/f1/drivers/\(id)/driverStandings.json")
            case .currentDriverStandings:
                return
                    URLComponents(string: "https://ergast.com/api/f1/current/driverStandings.json")
            case .constructorDetail(let year, let id):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/constructors/\(id)/results.json?limit=50")
            case .constructorParticipated(id: let id):
                return
                    URLComponents(string: "https://ergast.com/api/f1/constructors/\(id)/constructorstandings.json?limit=70")
            case .currentConstructorStandings:
                return
                    URLComponents(string: "https://ergast.com/api/f1/current/constructorStandings.json")
            case .seasonsOfficialConstructorsCup:
                return
                    URLComponents(string: "https://ergast.com/api/f1/constructors/ferrari/constructorstandings.json")
            case .concreteRaceResults(year: let year, roundId: let round):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(year)/\(round)/results.json")
            }
        }
    }
    

    // MARK: - Public Methods
    
    static func requestDriverStandings(year: String, completion: @escaping (DriverStandingsGroup?, Error?) -> Void) {
        request(endpoint: .driverStandings(year: year), completion: completion)
    }
    
    static func requestConstructorStandings(year: String, completion: @escaping (ConstructorStandingsGroup?, Error?) -> Void) {
        request(endpoint: .constructorStandings(year: year), completion: completion)
    }
    
    static func requestSeasons(completion: @escaping (Season?, Error?) -> Void) {
        request(endpoint: .season, completion: completion)
    }
    
    static func requestFirstPlaceResultInSeason(year: String, completion: @escaping (RaceResult?, Error?) -> Void) {
        request(endpoint: .firstPlaceResultInSeason(year: year), completion: completion)
    }
    
    static func requestDriverDetailResult(year: String, id: String, completion: @escaping (DriverDetail?, Error?) -> Void) {
        request(endpoint: .driverDetail(year: year, id: id), completion: completion)
    }
    
    static func requestDriverParticipated(id: String, completion: @escaping (TwoOptions?, Error?) -> Void) {
        request(endpoint: .driverParticipated(id: id), completion: completion)
    }
    
    static func requestCurrentDriverStandings(completion: @escaping (CurrentDriverStandings?, Error?) -> Void) {
        request(endpoint: .currentDriverStandings, completion: completion)
    }
    
    static func requestConstructorDetailResult(year: String, id: String, completion: @escaping (ConstructorDetail?, Error?) -> Void) {
        request(endpoint: .constructorDetail(year: year, id: id), completion: completion)
    }
    
    static func requestConstructorParticipated(id: String, completion: @escaping (ConstructorParticipated?, Error?) -> Void) {
        request(endpoint: .constructorParticipated(id: id), completion: completion)
    }
    
    static func requestCurrentConstructorStandings(completion: @escaping (CurrentConstructorStandings?, Error?) -> Void) {
        request(endpoint: .currentConstructorStandings, completion: completion)
    }
    
    static func requestSeasonsOfficialConstructorsCup(completion: @escaping (TwoOptions?, Error?) -> Void) {
        request(endpoint: .seasonsOfficialConstructorsCup, completion: completion)
    }
    
    static func requestConcreteRaceResults(year: String, roundId: String, completion: @escaping (RaceDetail?, Error?) -> Void) {
        request(endpoint: .concreteRaceResults(year: year, roundId: roundId), completion: completion)
    }
    
    
    // MARK: - Private Methods
    
    /// Generic request method
    private static func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.global().async {
            guard let urlComponents = endpoint.urlComponents else { return }
            guard let url = urlComponents.url else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("ERROR1: \(String(describing: error))")
                    return
                }
                
                guard let data = data else { return print("NO DATA") }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async { completion(object, nil) }
                } catch {
                    DispatchQueue.main.async { completion(nil, error) }
                    print("ERROR2: \(String(describing: error))")
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}

