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
import CoreData

class WeatherViewController: UIViewController, DarkSkyWeatherInfoDelegate {
    
    let secondsInDay = 86400

    var darkSkyWeatherInfo: DarkSkyWeatherInfo!
    
    var dayLabels = Array<UILabel>()
    var minLabels = Array<UILabel>()
    var maxLabels = Array<UILabel>()
    var minTempLabels = Array<UILabel>()
    var maxTempLabels = Array<UILabel>()
    var allWeatherTypes = Array<UILabel>()
    
    @IBOutlet weak var cityStateInputField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var dayZeroLabel: UILabel!
    @IBOutlet weak var dayOneLabel: UILabel!
    @IBOutlet weak var dayTwoLabel: UILabel!
    @IBOutlet weak var dayThreeLabel: UILabel!
    @IBOutlet weak var dayFourLabel: UILabel!
    @IBOutlet weak var dayFiveLabel: UILabel!
    @IBOutlet weak var daySixLabel: UILabel!
    @IBOutlet weak var daySevenLabel: UILabel!
    
    @IBOutlet weak var minLabel0: UILabel!
    @IBOutlet weak var minLabel1: UILabel!
    @IBOutlet weak var minLabel2: UILabel!
    @IBOutlet weak var minLabel3: UILabel!
    @IBOutlet weak var minLabel4: UILabel!
    @IBOutlet weak var minLabel5: UILabel!
    @IBOutlet weak var minLabel6: UILabel!
    @IBOutlet weak var minLabel7: UILabel!
    
    @IBOutlet weak var minTemp0: UILabel!
    @IBOutlet weak var minTemp1: UILabel!
    @IBOutlet weak var minTemp2: UILabel!
    @IBOutlet weak var minTemp3: UILabel!
    @IBOutlet weak var minTemp4: UILabel!
    @IBOutlet weak var minTemp5: UILabel!
    @IBOutlet weak var minTemp6: UILabel!
    @IBOutlet weak var minTemp7: UILabel!

    @IBOutlet weak var maxLabel0: UILabel!
    @IBOutlet weak var maxLabel1: UILabel!
    @IBOutlet weak var maxLabel2: UILabel!
    @IBOutlet weak var maxLabel3: UILabel!
    @IBOutlet weak var maxLabel4: UILabel!
    @IBOutlet weak var maxLabel5: UILabel!
    @IBOutlet weak var maxLabel6: UILabel!
    @IBOutlet weak var maxLabel7: UILabel!
    
    @IBOutlet weak var maxTemp0: UILabel!
    @IBOutlet weak var maxTemp1: UILabel!
    @IBOutlet weak var maxTemp2: UILabel!
    @IBOutlet weak var maxTemp3: UILabel!
    @IBOutlet weak var maxTemp4: UILabel!
    @IBOutlet weak var maxTemp5: UILabel!
    @IBOutlet weak var maxTemp6: UILabel!
    @IBOutlet weak var maxTemp7: UILabel!
    
    @IBOutlet weak var weatherType0: UILabel!
    @IBOutlet weak var weatherType1: UILabel!
    @IBOutlet weak var weatherType2: UILabel!
    @IBOutlet weak var weatherType3: UILabel!
    @IBOutlet weak var weatherType4: UILabel!
    @IBOutlet weak var weatherType5: UILabel!
    @IBOutlet weak var weatherType6: UILabel!
    @IBOutlet weak var weatherType7: UILabel!
    
    func didGetWeatherInfo(weather: DailyWeather) {
        DispatchQueue.main.async {
            for i in 0..<8 {
                print("*** DAY \(i) ***")
                print("apparent temperature min: \(weather.allAppTempMin[i])")
                print("apparent temperature max: \(weather.allAppTempMax[i])")
                print("actual temperature min: \(weather.allTempMin[i])")
                self.minTempLabels[i].text = "\(weather.allTempMin[i])"
                print("actual temperature max: \(weather.allTempMax[i])")
                self.maxTempLabels[i].text = "\(weather.allTempMax[i])"
                print("precip type: \(weather.allPrecip[i])")
                print("precip prob: \(weather.allPrecipProb[i])")
                print("cloud cover %: \(weather.allCloudCover[i])")
                print("humidity %: \(weather.allHumidity[i])")
                print("weather type: \(weather.allWeatherTypes[i])")
                self.allWeatherTypes[i].text = self.interpretWeatherTypes(weatherTypes: weather.allWeatherTypes[i])
            }
        }
    }
    
    func didNotGetWeatherInfo(error: Error) {
        DispatchQueue.main.async {
            print("didn't get weather: \(error)")
        }
    }
    
    func interpretWeatherTypes(weatherTypes: Array<WeatherType>) -> String {
        var weatherDescription = ""
        for weather in weatherTypes {
            if weather == .sunny {
                weatherDescription.append("sunny, ")
            } else if weather == .cloudy_high {
                weatherDescription.append("very cloudy, ")
            } else if weather == .cloudy_partly {
                weatherDescription.append("partly cloudy,")
            } else if weather == .rain_low {
                weatherDescription.append("low rain, ")
            } else if weather == .rain_med {
                weatherDescription.append("some rain, ")
            } else if weather == .rain_high {
                weatherDescription.append("high rain, ")
            } else if weather == .snow_high {
                weatherDescription.append("lots of snow, ")
            } else if weather == .snow_med {
                weatherDescription.append("some snow, ")
            } else if weather == .snow_low {
                weatherDescription.append("low snow, ")
            } else if weather == .sleet_low {
                weatherDescription.append("low sleet, ")
            } else if weather == .sleet_med {
                weatherDescription.append("medium sleet, ")
            } else if weather == .sleet_high {
                weatherDescription.append("lots of sleet, ")
            } else if weather == .humid_low {
                weatherDescription.append("low humidity")
            } else if weather == .humid_med {
                weatherDescription.append("some humidity")
            } else if weather == .humid_high {
                weatherDescription.append("lots of humidity")
            }
        }
        return weatherDescription
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkSkyWeatherInfo = DarkSkyWeatherInfo(delegate: self)
        
        dayLabels.append(dayZeroLabel)
        dayLabels.append(dayOneLabel)
        dayLabels.append(dayTwoLabel)
        dayLabels.append(dayThreeLabel)
        dayLabels.append(dayFourLabel)
        dayLabels.append(dayFiveLabel)
        dayLabels.append(daySixLabel)
        dayLabels.append(daySevenLabel)
        
        minLabels.append(minLabel0)
        minLabels.append(minLabel1)
        minLabels.append(minLabel2)
        minLabels.append(minLabel3)
        minLabels.append(minLabel4)
        minLabels.append(minLabel5)
        minLabels.append(minLabel6)
        minLabels.append(minLabel7)
        
        minTempLabels.append(minTemp0)
        minTempLabels.append(minTemp1)
        minTempLabels.append(minTemp2)
        minTempLabels.append(minTemp3)
        minTempLabels.append(minTemp4)
        minTempLabels.append(minTemp5)
        minTempLabels.append(minTemp6)
        minTempLabels.append(minTemp7)
        
        maxLabels.append(maxLabel0)
        maxLabels.append(maxLabel1)
        maxLabels.append(maxLabel2)
        maxLabels.append(maxLabel3)
        maxLabels.append(maxLabel4)
        maxLabels.append(maxLabel5)
        maxLabels.append(maxLabel6)
        maxLabels.append(maxLabel7)
        
        maxTempLabels.append(maxTemp0)
        maxTempLabels.append(maxTemp1)
        maxTempLabels.append(maxTemp2)
        maxTempLabels.append(maxTemp3)
        maxTempLabels.append(maxTemp4)
        maxTempLabels.append(maxTemp5)
        maxTempLabels.append(maxTemp6)
        maxTempLabels.append(maxTemp7)
        
        allWeatherTypes.append(weatherType0)
        allWeatherTypes.append(weatherType1)
        allWeatherTypes.append(weatherType2)
        allWeatherTypes.append(weatherType3)
        allWeatherTypes.append(weatherType4)
        allWeatherTypes.append(weatherType5)
        allWeatherTypes.append(weatherType6)
        allWeatherTypes.append(weatherType7)
        
        for label in dayLabels {
            scrollView.addSubview(label)
            label.isHidden = true
            label.frame.origin.x = 40
        }
        
        
        for label in minLabels {
            scrollView.addSubview(label)
            label.isHidden = true
            label.text = "Min: "
            label.frame.origin.x = 40
        }
        
        for label in minTempLabels {
            scrollView.addSubview(label)
            label.isHidden = true
            label.frame.origin.x = 90
        }
        
        for label in maxLabels {
            scrollView.addSubview(label)
            label.isHidden = true
            label.text = "Max: "
            label.frame.origin.x = 240
        }
        
        for label in maxTempLabels {
            scrollView.addSubview(label)
            label.isHidden = true
            label.frame.origin.x = 290
        }
        
        for lbl in allWeatherTypes {
            scrollView.addSubview(lbl)
            lbl.isHidden = true
            lbl.frame.origin.x = 40
        }
        
        scrollView.contentSize = CGSize(width: dataView.frame.minX, height: dataView.frame.maxY)
        dataView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dataView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dataView.topAnchor.constraint(equalTo: cityStateInputField.bottomAnchor).isActive = true
        dataView.addSubview(scrollView)
        
        cityStateInputField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Clothing")
        
        do {
            AddClothingViewController.globalVariables.allClothing = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func allInfoOf(theCity city: String, withWeatherInfo darkSkyWeatherInfo: DarkSkyWeatherInfo, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geoCoder = CLGeocoder()
        
        print("user in all info")
        geoCoder.geocodeAddressString(city) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
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
        
        allInfoOf(theCity: cityInput, withWeatherInfo: darkSkyWeatherInfo) { (coordinate, error) in
            print("extracting weather info from: \(cityInput), long: \(coordinate.longitude), lat: \(coordinate.latitude)")
            
            self.darkSkyWeatherInfo.extractDarkSkyWeatherInfo(longitudeCoord: coordinate.longitude, latitudeCoord: coordinate.latitude)
            
            print("user hit return button")
        }
        let df = DateFormatter()
        df.timeStyle = .none
        df.dateStyle = .medium
        var date = Date()
        dayZeroLabel.text = df.string(from: date)
        dayZeroLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        dayOneLabel.text = df.string(from: date)
        dayOneLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        dayTwoLabel.text = df.string(from: date)
        dayTwoLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        dayThreeLabel.text = df.string(from: date)
        dayThreeLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        dayFourLabel.text = df.string(from: date)
        dayFourLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        dayFiveLabel.text = df.string(from: date)
        dayFiveLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        daySixLabel.text = df.string(from: date)
        daySixLabel.isHidden = false
        
        date = date.addingTimeInterval(TimeInterval(secondsInDay))
        daySevenLabel.text = df.string(from: date)
        daySevenLabel.isHidden = false
        
        for label in minLabels {
            label.isHidden = false
        }
        
        for label in minTempLabels {
            label.isHidden = false
        }
        
        for label in maxLabels {
            label.isHidden = false
        }
        
        for label in maxTempLabels {
            label.isHidden = false
        }
        
        for label in allWeatherTypes {
            label.isHidden = false
        }
        
        print("amount of clothing: \(AddClothingViewController.globalVariables.allClothing.count)")
        
        return true
    }
    
    
}

