//
//  CountriesData.swift
//  Countries
//
//  Created by Solovei Ihor on 02.03.2023.
//

import Foundation

struct CountriesData: Codable {
    let name: Name
    let flag: String
    let capital: [String]
    let subregion: String
    let population: Double
    let currencies: [String: Info]
}

struct Name: Codable {
    let common: String
}

struct Info: Codable {
    let name: String
    let symbol: String
}

