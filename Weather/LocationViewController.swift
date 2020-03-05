//
//  LocationViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 11/7/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

/*
 In this View Controller, the user should be able to select what location they will use
 Initially, the user should be able to choose whether the app can use their location
 If the app can't, the user should be able to input the location they are in currently
 */

import UIKit

class LocationViewController: UIViewController {
    
    static var currentWeather: DailyWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
