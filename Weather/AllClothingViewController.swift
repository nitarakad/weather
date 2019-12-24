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

        let currX = self.view.bounds.minX + 32.0
        var currY = self.view.bounds.minY + 10.0
        let widthL = CGFloat(200.0)
        let heightL = CGFloat(50.0)
        for eachImage in AddClothingViewController.globalVariables.allClothing {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: currX, y: currY, width: eachImage.size.width/10.0, height: eachImage.size.height/10.0)
            let label = UILabel()
            label.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + 1.0, width: widthL, height: heightL)
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
