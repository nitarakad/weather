//
//  DarkSkyWeatherInfo.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/29/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

// This file is getting weather data from the Dark Sky API
// We will be utilizing this data to get daily weather measurements

import Foundation

protocol DarkSkyWeatherInfoDelegate {
    func didGetWeatherInfo(weather: DailyWeather)
    func didNotGetWeatherInfo(error: Error)
}

class DarkSkyWeatherInfo {
    
    // api key: fdd72903a77ffa0c395fbae9c1bcfed4
    
    private let errorLog = "DarkSkyWeatherInfo/"
    
    private let darkSkyAPIKey = "fdd72903a77ffa0c395fbae9c1bcfed4"
    
    private var delegate: DarkSkyWeatherInfoDelegate
    
    init(delegate: DarkSkyWeatherInfoDelegate) {
      self.delegate = delegate
    }
    
    func extractDarkSkyWeatherInfo(longitudeCoord longCoord: Double, latitudeCoord latCoord: Double) {
        guard let darkSkyBaseURL = URL(string: "https://api.darksky.net/forecast/") else {
            print("\(errorLog)/getDarkSkyWeatherInfo/unable to retrieve base url")
            return
        }
        
        let darkSkyBaseURLWithKey = darkSkyBaseURL.appendingPathComponent(darkSkyAPIKey)
        
        let darkSkyURL = darkSkyBaseURLWithKey.appendingPathComponent("\(longCoord),\(latCoord)")
        
        let networkSession = URLSession.shared
        
        let task = networkSession.dataTask(with: darkSkyURL) { (data, response, error) in
            if let error = error {
                print("\(self.errorLog)/getDarkSkyWeatherInfo/request for data task failed/error: \(error)")
            } else if let data = data {
                do {
                    let darkSkyWeatherInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                    
                    let dailyWeatherInfo = darkSkyWeatherInfo["daily"]!["data"]! as! Array<Dictionary<String, AnyObject>>
                    
                    let darkSkyDailyWeatherInfo = DailyWeather(dailyWeatherInfo: dailyWeatherInfo)
                    
                    self.delegate.didGetWeatherInfo(weather: darkSkyDailyWeatherInfo)
                    
                } catch let jsonError as Error {
                    self.delegate.didNotGetWeatherInfo(error: jsonError)
                }
            }
        }
        task.resume()
    }
    
}

struct DailyWeather {
    var allAppTempMin: Array<Double>
    var allAppTempMax: Array<Double>
    var allTempMin: Array<Double>
    var allTempMax: Array<Double>
    
    init(dailyWeatherInfo: Array<Dictionary<String, AnyObject>>) {
        
        allAppTempMin = Array<Double>()
        allAppTempMax = Array<Double>()
        allTempMin = Array<Double>()
        allTempMax = Array<Double>()
        
        for day in dailyWeatherInfo {
            let currAppTempMin = day["apparentTemperatureMin"]! as! Double
            allAppTempMin.append(currAppTempMin)
            let currAppTempMax = day["apparentTemperatureMax"]! as! Double
            allAppTempMax.append(currAppTempMax)
            let currTempMin = day["temperatureMin"]! as! Double
            allTempMin.append(currTempMin)
            let currTempMax = day["temperatureMax"]! as! Double
            allTempMax.append(currTempMax)
        }
    }
}
