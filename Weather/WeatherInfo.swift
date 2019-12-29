//
//  WeatherInfo.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/25/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation

class WeatherInfo {
    
    // private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather" // 1 day
    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/forecast" // 5 day
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
                do {
                    let weatherInfo = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    /*
                     ALL KEYS:
                     *city: coord (lat, lon), country, id, name, population, sunrise, sunset, timezone
                     *list: clouds (all), dt, "dt_txt", main ("feels_like", "grnd_level", humidity,
                     pressure, "sea_level", temp, "temp_kf", "temp_max", "temp_min"), sys (pod),
                     weather (description, icon, id, main), wind (deg, speed)
                        - there are 40 occurences of each of these in the list
                     *
                     */
                    
                    let city = weatherInfo["city"]!["name"]!
                    print(city!)
                    
                    let numberOfItems = weatherInfo["cnt"]! as! Int
                    print(numberOfItems)
                    
                    let theList = weatherInfo["list"]! as! [[String: AnyObject]]
                    
                    for i in 0..<numberOfItems {
                        print("date: \(theList[i]["dt_txt"]!)")
                        print("max temp: \(theList[i]["main"]!["temp_max"]!)")
                        print("min temp: \(theList[i]["main"]!["temp_min"]!)")
                    }
                    
                } catch let jsonError as Error {
                    print("JSON error description: \(jsonError)")
                }
            }
        }
        
        task.resume()
        
    }
    
}
