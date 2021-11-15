//
//  Planet.swift
//  PlanetsCombine
//
//  Created by Nalinda Wickramarathna on 11/13/21.
//

import Foundation

struct Planets: Codable {
    let count: Int
    let results: [Planet]
}

struct Planet: Codable {
    let name: String
    let climate: String
    let orbital_period: String
    let gravity: String
}
