//
//  CountryModel.swift
//  Countries
//
//  Created by Solovei Ihor on 02.03.2023.
//

import Foundation

struct CountriesModel {
    
    let countryName: String
    let countryFlag: String
    let countryCapital: String
    let countryRegion: String
    let countryPopulation: Double
    let countryCurrency: String
    
    var countryPopulationString: String {
        let countryPopulationDouble = countryPopulation / 1_000_000
        let population = String(format: "%.1f", countryPopulationDouble)
        return String("\(population)m")
    }
    
    var countryCurrencyString: String {
        return String("\(countryCurrency)")
    }
    
}
