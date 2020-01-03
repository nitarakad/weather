//
//  WeatherViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/19/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

/*
 In this View Controller, the user should be able to view the weather based off of their
 location they inputted in the Location View Controller
 */


import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController, DarkSkyWeatherInfoDelegate {
    
    var darkSkyWeatherInfo: DarkSkyWeatherInfo!
    
    @IBOutlet weak var cityStateInputField: UITextField!

    func didGetWeatherInfo(weather: DailyWeather) {
        DispatchQueue.main.async {
            for i in 0..<8 {
                print("*** DAY \(i) ***")
                print("apparent temperature min: \(weather.allAppTempMin[i])")
                print("apparent temperature max: \(weather.allAppTempMax[i])")
                print("actual temperature min: \(weather.allTempMin[i])")
                print("actual temperature max: \(weather.allTempMax[i])")
            }
        }
    }
    
    func didNotGetWeatherInfo(error: Error) {
        DispatchQueue.main.async {
            print("didn't get weather: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkSkyWeatherInfo = DarkSkyWeatherInfo(delegate: self)
        
        cityStateInputField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func allInfoOf(theCity city: String, withWeatherInfo darkSkyWeatherInfo: DarkSkyWeatherInfo) {
        let geoCoder = CLGeocoder()
        
        print("user in all info")
        geoCoder.geocodeAddressString(city) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                return
            }
            
            print("extracting weather info from: \(city), long: \(location.coordinate.longitude), lat: \(location.coordinate.latitude)")
            darkSkyWeatherInfo.extractDarkSkyWeatherInfo(longitudeCoord: location.coordinate.longitude, latitudeCoord: location.coordinate.latitude)
            
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityStateInputField.resignFirstResponder()
        guard let cityInput = cityStateInputField.text, cityInput.count > 0 else {
            print("invalid city input, empty text given")
            return false
        }
        
        
        allInfoOf(theCity: cityInput, withWeatherInfo: darkSkyWeatherInfo)
        
        print("user hit return button")
        
        return true
    }
    
}

