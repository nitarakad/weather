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

class DarkSkyWeatherInfo {
    
    // api key: fdd72903a77ffa0c395fbae9c1bcfed4
    
    private let errorLog = "DarkSkyWeatherInfo/"
    
    private let darkSkyAPIKey = "fdd72903a77ffa0c395fbae9c1bcfed4"
    
    func getDarkSkyWeatherInfo(longitudeCoord longCoord: Double, latitudeCoord latCoord: Double) {
        guard let darkSkyBaseURL = URL(string: "https://api.darksky.net/forecast/") else {
            print("\(errorLog)/getDarkSkyWeatherInfo/unable to retrieve base url")
            return
        }
        
        let darkSkyBaseURLWithKey = darkSkyBaseURL.appendingPathComponent(darkSkyAPIKey)
        
        let darkSkyURL = darkSkyBaseURLWithKey.appendingPathComponent("\(longCoord),\(latCoord)")
        
        URLSession.shared.dataTask(with: darkSkyURL) { (data, response, error) in
            if let error = error {
                print("\(self.errorLog)/getDarkSkyWeatherInfo/request for data task failed/error: \(error)")
            } else if let data = data {
                let rawJSON = String(data: data, encoding: String.Encoding.utf8)!
                //print(rawJSON)
                
                do {
                    let darkSkyWeatherInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                    
//                    for key in darkSkyWeatherInfo.keys {
//                        print("****KEY: \(key) ****")
//                        let contentsOfKey = darkSkyWeatherInfo[key]
//                        print("contents of key:\n\(contentsOfKey)")
//                    }
                    
//                    let allDailyWeatherInfo = darkSkyWeatherInfo["daily"] as! Dictionary<String, AnyObject>
//                    for day in allDailyWeatherInfo {
//                        print("*****")
//                        print(day)
//                    }
                    
                    let justDailyWeatherInfo = darkSkyWeatherInfo["daily"]!["data"]! as! Array<AnyObject>
                    for day in justDailyWeatherInfo {
                        print("******")
                        print(day)
                    }
                    
                    
                } catch let jsonError as Error {
                    print("\(self.errorLog)/getDarkSkyWeatherInfo/unable to serialize dark sky weather info/error: \(jsonError)")
                }
                
            }
        }.resume()
    }
    
    
}
