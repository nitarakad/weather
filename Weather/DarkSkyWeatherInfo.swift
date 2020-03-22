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
import UIKit

protocol DarkSkyWeatherInfoDelegate {
    func didGetWeatherInfo(weather: DailyWeather)
    func didNotGetWeatherInfo(error: Error)
}

enum WeatherType {
    case sunny
    case rain_high
    case rain_med
    case rain_low
    case snow_high
    case snow_med
    case snow_low
    case sleet_high
    case sleet_med
    case sleet_low
    case cloudy_high
    case cloudy_partly
    case humid_high
    case humid_med
    case humid_low
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
        
        let darkSkyURL = darkSkyBaseURLWithKey.appendingPathComponent("\(latCoord),\(longCoord)")
        
        let networkSession = URLSession.shared
        
        networkSession.dataTask(with: darkSkyURL) { (data, response, error) in
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
        }.resume()
    }
    
}

struct DailyWeather {
    var allAppTempMin: Array<Double>
    var allAppTempMax: Array<Double>
    var allTempMin: Array<Double>
    var allTempMax: Array<Double>
    var allPrecip: Array<String>
    var allPrecipProb: Array<Double>
    var allCloudCover: Array<Double>
    var allHumidity: Array<Double>
    var allWeatherTypes: Array<Array<WeatherType>>
    
    init(dailyWeatherInfo: Array<Dictionary<String, AnyObject>>) {
        
        allAppTempMin = Array<Double>()
        allAppTempMax = Array<Double>()
        allTempMin = Array<Double>()
        allTempMax = Array<Double>()
        allPrecip = Array<String>()
        allPrecipProb = Array<Double>()
        allCloudCover = Array<Double>()
        allHumidity = Array<Double>()
        allWeatherTypes = Array<Array<WeatherType>>()
        
        var i = 0
        for day in dailyWeatherInfo {
            //print(dailyWeatherInfo)
            allWeatherTypes.append(Array<WeatherType>())
            let currAppTempMin = day["apparentTemperatureMin"]! as! Double
            allAppTempMin.append(currAppTempMin)
            let currAppTempMax = day["apparentTemperatureMax"]! as! Double
            allAppTempMax.append(currAppTempMax)
            let currTempMin = day["temperatureMin"]! as! Double
            allTempMin.append(currTempMin)
            let currTempMax = day["temperatureMax"]! as! Double
            allTempMax.append(currTempMax)
            let precipProb = day["precipProbability"]! as! Double
            allPrecipProb.append(precipProb)
            let precipType = day["precipType"] as? String
            if precipType == nil {
                allPrecip.append("none")
            } else {
                let precip = precipType!
                allPrecip.append(precip)
                allWeatherTypes[i].append(typeOfPrecip(precipType: precip, precipProb: precipProb))
            }
            let cloudCover = day["cloudCover"]! as! Double
            allCloudCover.append(cloudCover)
            allWeatherTypes[i].append(amtOfClouds(cloudCover: cloudCover))
            let humidity = day["humidity"]! as! Double
            allHumidity.append(humidity)
            allWeatherTypes[i].append(amtOfHumidity(humidity: humidity))
            
            i = i + 1
        }
    }
    
    func amtOfHumidity(humidity: Double) -> WeatherType {
        if humidity > 0.67 {
            return .humid_high
        } else if humidity > 0.33 {
            return .humid_med
        } else {
            return .humid_low
        }
    }
    
    func amtOfClouds(cloudCover: Double) -> WeatherType {
        if cloudCover > 0.67 {
            return .cloudy_high
        } else if cloudCover > 0.33 {
            return .cloudy_partly
        } else {
            return .sunny
        }
    }
    
    func typeOfPrecip(precipType: String, precipProb: Double) -> WeatherType {
        if precipType == "rain" {
            if precipProb > 0.67 {
                return .rain_high
            } else if precipProb > 0.33 {
                return .rain_med
            } else {
                return .rain_low
            }
        } else if precipType == "snow" {
            if precipProb > 0.67 {
                return .snow_high
            } else if precipProb > 0.33 {
                return .snow_med
            } else {
                return .snow_low
            }
        } else {
            if precipProb > 0.67 {
                return .sleet_high
            } else if precipProb > 0.33 {
                return .sleet_med
            } else {
                return .sleet_low
            }
        }
    }
}
