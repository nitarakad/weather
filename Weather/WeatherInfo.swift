//
//  WeatherInfo.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/25/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation

class WeatherInfo {
    
    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "c89bc1dcb1b2def2d0944f132f4bf16a"
    
    func getWeather(city: String) {
        
        let networkingSession = URLSession.shared
        let URLString = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)"
        let weatherRequestURL = URL(string: URLString)!
        
        let task = networkingSession.dataTask(with: weatherRequestURL) { (data, response, error) in
            if let error = error {
                print("Error obtained: \(error)")
            } else {
                let stringToPrint = String(data: data!, encoding: String.Encoding.utf8)
                print("Data:\n\(stringToPrint!)")
            }
        }
        
        task.resume()
        
    }
    
}
