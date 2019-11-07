//
//  ViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 10/27/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let welcomeMessage = "Welcome to the Weather App"
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let welcomeLabel = UILabel()
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.text = welcomeMessage
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(welcomeLabel)
            
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        let locationScreenButton = UIButton()
        locationScreenButton.backgroundColor = .systemBlue
        locationScreenButton.layer.cornerRadius = 24.0
        locationScreenButton.setTitleColor(.white, for: .normal)
        locationScreenButton.setTitle("Set Location", for: .normal)
        locationScreenButton.addTarget(self, action: #selector(toLocationScreen), for: .touchUpInside)
        locationScreenButton.translatesAutoresizingMaskIntoConstraints = false
        locationScreenButton.setTitleColor(.systemGray2, for: .highlighted)
        self.view.addSubview(locationScreenButton)
                
        NSLayoutConstraint.activate([
            locationScreenButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48.0),
            locationScreenButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
            locationScreenButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            locationScreenButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }
    
    @objc private func toLocationScreen() {
        print("click")
        let locationScreen = LocationViewController()
        self.navigationController?.pushViewController(locationScreen, animated: true)
    }
        
}


