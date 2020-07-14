//
//  Api.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class API {
    enum EndPoint {
        case driverStandings
//        case driverStandings(season: String)
        case constructorStandings(season: String)
        
        var urlComponents: URLComponents? {
            switch self {
            case .driverStandings:
                return
                    URLComponents(string: "https://ergast.com/api/f1/2020/driverStandings.json")
            case .constructorStandings(let season):
                return
                    URLComponents(string: "https://ergast.com/api/f1/\(season)/constructorStandings.json")
            }
        }
    }
    // MARK: - Public Methods
    static func requestDriverStandings(completion: @escaping (Welcome?, Error?) -> Void) {
        request(endpoint: .driverStandings, completion: completion)
    }
//    static func requestDriverStandings(season: String, completion: @escaping (Driver?, Error?) -> Void) {
//        request(endpoint: .driverStandings(season: season), completion: completion)
//    }
    
//    static func requestConstructorStandings(season: String, completion: @escaping (Data?, Error?) -> Void) {
//        request(endpoint: .constructorStandings(season: season), completion: completion)
//    }
    
    // MARK: - Private Methods
    
    /// Generic request method
    private static func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.global().async {
            guard let urlComponents = endpoint.urlComponents else { return }
            guard let url = urlComponents.url else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("ERRORZZZ: \(String(describing: error))")
                    return
                }
                
                guard let data = data else { return print("NO DATA") }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async { completion(object, nil) }
                } catch {
                    DispatchQueue.main.async { completion(nil, error) }
                    print("ERROR!!!: \(String(describing: error))")
                }
            }
            task.resume()
        }
    }
}
