//
//  AllClothingViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/23/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation
import UIKit

class AllClothingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let currX = self.view.bounds.minX
        var currY = self.view.bounds.minY
        let widthIV = CGFloat(200.0)
        let heightIV = CGFloat(400.0)
        let widthL = CGFloat(200.0)
        let heightL = CGFloat(100.0)
        for eachImage in AddClothingViewController.globalVariables.allClothing {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: currX, y: currY, width: widthIV, height: heightIV)
            let label = UILabel()
            label.frame = CGRect(x: imageView.bounds.minX, y: imageView.bounds.maxY + 5.0, width: widthL, height: heightL)
            imageView.image = eachImage
            label.text = AddClothingViewController.globalVariables.clothingDict[eachImage]
            self.view.addSubview(imageView)
            self.view.addSubview(label)
            currY = label.bounds.maxY + 15.0
        }
        
        
    }
    
}
