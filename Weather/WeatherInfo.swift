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
    private var weatherListInfoCount = 0
    
    func getWeather(city: String) {
        let networkingSession = URLSession.shared
        let URLString = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)"
        let weatherRequestURL = URL(string: URLString)!
        
        let task = networkingSession.dataTask(with: weatherRequestURL) { (data, response, error) in
            if let error = error {
                print("Error obtained: \(error)")
            } else {
                let stringToPrint = String(data: data!, encoding: String.Encoding.utf8)
                //print("Data:\n\(stringToPrint!)")
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
                    
                    let weatherInfoList = weatherInfo["list"]! as! [[String: AnyObject]]
                    let currDateAndTimeRaw = weatherInfoList[0]["dt_txt"]! as! String
                    var currDateAndTime = currDateAndTimeRaw.split(separator: " ").map { (substring) in
                        return String(substring)
                    }
                    
                    print("date starts at: \(currDateAndTime[0])")
                    print("time starts at: \(currDateAndTime[1])")
                    print(weatherInfoList)
                    self.weatherListInfoCount = weatherInfo["cnt"] as! Int
                    var allDates = Array<String>()
                    var allMaxTemps = Array<Array<Double>>()
                    var allMinTemps = Array<Array<Double>>()
                    allDates.append(currDateAndTime[0])
                    allMaxTemps.append(Array<Double>())
                    allMinTemps.append(Array<Double>())
                    var currDay = 0
                    for i in 0..<self.weatherListInfoCount {
                        let dateAndTimeRaw = weatherInfoList[i]["dt_txt"]! as! String
                        //print("***DATE AND TIME RAW: \(dateAndTimeRaw)")
                        let dateAndTime = dateAndTimeRaw.split(separator: " ").map { (substring) in
                            return String(substring)
                        }
                        
                        //print("***DATE: \(dateAndTime)")
                        if currDateAndTime[0] == dateAndTime[0] {
                            if (currDay < 5) {
                                //print("***CURR DATE: \(currDateAndTime)")
                                //print("***DATE: \(dateAndTime)")
                                let maxTemp = weatherInfoList[i]["main"]!["temp_max"]! as! Double
                                let minTemp = weatherInfoList[i]["main"]!["temp_min"]! as! Double
                                allMaxTemps[currDay].append(maxTemp)
                                allMinTemps[currDay].append(minTemp)
                            }
                        } else {
                            currDay = currDay + 1
                            if (currDay < 5) {
                                //print("Date: \(currDateAndTime)\nmaxTemps:\(allMaxTemps[currDay-1])\nminTemps:\(allMinTemps[currDay-1])")
                                allMaxTemps.append(Array<Double>())
                                allMinTemps.append(Array<Double>())
                                currDateAndTime = dateAndTime
                                allDates.append(currDateAndTime[0])
                                let maxTemp = weatherInfoList[i]["main"]!["temp_max"]! as! Double
                                let minTemp = weatherInfoList[i]["main"]!["temp_min"]! as! Double
                                allMaxTemps[currDay].append(maxTemp)
                                allMinTemps[currDay].append(minTemp)
                            }
                        }
                    }
                    
                    var maxTempForDate = Dictionary<String, Double>()
                    var minTempForDate = Dictionary<String, Double>()
                    
                    var i = 0
                    for date in allDates {
                        maxTempForDate[date] = self.maxTempOf(allMaxTemps[i])
                        minTempForDate[date] = self.minTempOf(allMinTemps[i])
                        i += 1
                    }
                    
//                    print("max: \(maxTempForDate)")
//                    print("min: \(minTempForDate)")
                    
                } catch let jsonError as Error {
                    print("JSON error description: \(jsonError)")
                }
            }
        }
        
        task.resume()
        
    }
    
    //TODO: write method that gets the max temp out of the 8 max temps given in a day
    func maxTempOf(_ maxTempArray: [Double]) -> Double {
        var maxTemp = maxTempArray[0]
        for temp in maxTempArray {
            if temp > maxTemp {
                maxTemp = temp
            }
        }
        return maxTemp
    }
    
    //TODO: write method that gets the min temp out of the 8 min temps given in a day
    func minTempOf(_ minTempArray:[Double]) -> Double {
        var minTemp = minTempArray[0]
        for temp in minTempArray {
            if temp < minTemp {
                minTemp = temp
            }
        }
        return minTemp
    }
    
    
    
}
