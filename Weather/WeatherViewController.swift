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

// API Key: c89bc1dcb1b2def2d0944f132f4bf16a


import Foundation
import UIKit

class WeatherViewController: UIViewController, DarkSkyWeatherInfoDelegate {
    
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
    
    
    var darkSkyWeatherInfo: DarkSkyWeatherInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkSkyWeatherInfo = DarkSkyWeatherInfo(delegate: self)
        let atlLongCoord = 33.7490
        let atlLatCoord = -84.3880
        darkSkyWeatherInfo.extractDarkSkyWeatherInfo(longitudeCoord: atlLongCoord, latitudeCoord: atlLatCoord)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

