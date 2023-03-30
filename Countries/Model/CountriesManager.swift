//
//  CountriesData.swift
//  Countries
//
//  Created by Solovei Ihor on 02.03.2023.
//

import Foundation

protocol CountriesManagerDelegete {
    func didUpdateCountriesData(_ countriesManager: CountriesManager, country: CountriesModel)
    func didFailWithError(error: Error)
}

struct CountriesManager {
    
    let base = "https://restcountries.com/v3.1/name/"
    var delegate: CountriesManagerDelegete?
    
    func getCountryName(countryName: String) {
        let urlString = "\(base)\(countryName)"
        performRequest(for: urlString)
    }
    
    func performRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let country = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCountriesData(self, country: country)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ countriesData: Data) -> CountriesModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CountriesData].self, from: countriesData)
            let name = decodedData[0].name.common
            let flag = decodedData[0].flag
            let capital = decodedData[0].capital
            let region = decodedData[0].subregion
            let population = decodedData[0].population
            let currency = decodedData[0].currencies.first?.value.name
            
            let country = CountriesModel(
                countryName: name,
                countryFlag: flag,
                countryCapital: capital[0],
                countryRegion: region,
                countryPopulation: population,
                countryCurrency: currency!
            )
            
            return country
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
}
