//
//  NetworkService.swift
//  PlanetsCombine
//
//  Created by Nalinda Wickramarathna on 11/13/21.
//

import Foundation
import Combine

class NetworkService {
    
    static let planetsURL = "https://swapi.dev/api/planets/"
    static let imageURL = "https://picsum.photos/id/"
    
    static func getPlanets() -> Future<[Planet], Error> {
        return Future { promise in
            guard let url = URL(string: planetsURL) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let planets = try JSONDecoder().decode(Planets.self, from: data)
                    promise(.success(planets.results))
                }
                catch (let error) {
                    promise(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
