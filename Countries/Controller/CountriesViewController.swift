//
//  ViewController.swift
//  Countries
//
//  Created by Solovei Ihor on 28.02.2023.
//

import UIKit

class CountriesViewController: UIViewController {
    
    var countriesManager = CountriesManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        countriesManager.delegate = self
        
    }
    
}

extension CountriesViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type country name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text {
            countriesManager.getCountryName(countryName: name)
        }
        searchTextField.text = ""
    }
}

extension CountriesViewController: CountriesManagerDelegete {
    
    func didUpdateCountriesData(_ countriesManager: CountriesManager, country: CountriesModel) {
        DispatchQueue.main.async {
            self.countryNameLabel.text = country.countryName
            self.flagLabel.text = country.countryFlag
            self.capitalLabel.text = country.countryCapital
            self.regionLabel.text = country.countryRegion
            self.populationLabel.text = country.countryPopulationString
            self.currencyLabel.text = country.countryCurrency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
