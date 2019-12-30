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

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let weatherInfo = WeatherInfo()
        //weatherInfo.getWeather(city: "Belmont")
        
        let darkSkyWeatherInfo = DarkSkyWeatherInfo()
        let atlLongCoord = 33.7490
        let atlLatCoord = 84.3880
        darkSkyWeatherInfo.getDarkSkyWeatherInfo(longitudeCoord: atlLongCoord, latitudeCoord: atlLatCoord)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

