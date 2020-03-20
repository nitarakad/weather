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
    
    let secondsInDay = 86400

    var darkSkyWeatherInfo: DarkSkyWeatherInfo!
    
    @IBOutlet weak var cityStateInputField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dayZeroLabel: UILabel!
    @IBOutlet weak var dayOneLabel: UILabel!
    @IBOutlet weak var dayTwoLabel: UILabel!
    @IBOutlet weak var dayThreeLabel: UILabel!
    @IBOutlet weak var dayFourLabel: UILabel!
    @IBOutlet weak var dayFiveLabel: UILabel!
    @IBOutlet weak var daySixLabel: UILabel!
    @IBOutlet weak var daySevenLabel: UILabel!
    //@IBOutlet weak var getDailyWeatherButton: UIButton!

    func didGetWeatherInfo(weather: DailyWeather) {
        for i in 0..<8 {
            print("*** DAY \(i) ***")
            print("apparent temperature min: \(weather.allAppTempMin[i])")
            print("apparent temperature max: \(weather.allAppTempMax[i])")
            print("actual temperature min: \(weather.allTempMin[i])")
            print("actual temperature max: \(weather.allTempMax[i])")
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
        
        scrollView.addSubview(dayZeroLabel)
        scrollView.addSubview(dayOneLabel)
        scrollView.addSubview(dayTwoLabel)
        scrollView.addSubview(dayThreeLabel)
        scrollView.addSubview(dayFourLabel)
        scrollView.addSubview(dayFiveLabel)
        scrollView.addSubview(daySixLabel)
        scrollView.addSubview(daySevenLabel)

        dayZeroLabel.isHidden = true
        dayOneLabel.isHidden = true
        dayTwoLabel.isHidden = true
        dayThreeLabel.isHidden = true
        dayFourLabel.isHidden = true
        dayFiveLabel.isHidden = true
        daySixLabel.isHidden = true
        daySevenLabel.isHidden = true
        
        scrollView.contentSize = CGSize(width: dayZeroLabel.frame.minX, height: daySevenLabel.frame.maxY)
        
        cityStateInputField.delegate = self
        
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
        
        return true
    }
    
    
}

