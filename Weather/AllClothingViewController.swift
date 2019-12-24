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

        let currX = self.view.bounds.minX + 30.0
        var currY = self.view.bounds.minY + 10.0
        let widthIV = CGFloat(272.0)
        let heightIV = CGFloat(469.0)
        let widthL = CGFloat(200.0)
        let heightL = CGFloat(100.0)
        for eachImage in AddClothingViewController.globalVariables.allClothing {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: currX, y: currY, width: widthIV, height: heightIV)
            let label = UILabel()
            label.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + 2.5, width: widthL, height: heightL)
            imageView.image = eachImage
            label.text = AddClothingViewController.globalVariables.clothingDict[eachImage]
            self.view.addSubview(imageView)
            self.view.addSubview(label)
            scrollView.addSubview(imageView)
            scrollView.addSubview(label)
            currY = label.frame.maxY + 10.0
        }
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: currY+100)
    }
    
}
