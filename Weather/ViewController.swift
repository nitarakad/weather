//
//  ViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 10/27/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var welcomeButton: UIButton!
    var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        welcomeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        welcomeButton.backgroundColor = .cyan
        welcomeButton.setTitle("Welcome", for: .normal)
        welcomeButton.addTarget(self, action: #selector(navLocationScreen), for: .touchUpInside)
        welcomeButton.center = self.view.center
        self.view.addSubview(welcomeButton)
    }
    
    @objc func navLocationScreen() {
        print("clicked")
        welcomeButton.removeFromSuperview()
        myLabel = UILabel(frame: CGRect(x: 100, y: 400, width: 200, height: 100))
        myLabel.textColor = .blue
        myLabel.text = "location stuff"
        self.view.addSubview(myLabel)
        
    }
    
    


}

