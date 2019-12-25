//
//  AllClothingViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/23/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AllClothingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let currX = self.view.bounds.minX + 32.0
        var currY = self.view.bounds.minY + 10.0
        let widthL = CGFloat(200.0)
        let heightL = CGFloat(50.0)
//        for eachImage in AddClothingViewController.globalVariables.allClothing {
//            let imageView = UIImageView()
//            imageView.frame = CGRect(x: currX, y: currY, width: eachImage.size.width/10.0, height: eachImage.size.height/10.0)
//            let label = UILabel()
//            label.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + 1.0, width: widthL, height: heightL)
//            imageView.image = eachImage
//            label.text = AddClothingViewController.globalVariables.clothingDict[eachImage]
//            self.view.addSubview(imageView)
//            self.view.addSubview(label)
//            scrollView.addSubview(imageView)
//            scrollView.addSubview(label)
//            currY = label.frame.maxY + 10.0
//        }
        
        for clothing in AddClothingViewController.globalVariables.trying {
            let dataOfImage = clothing.value(forKeyPath: "image") as? Data
            let typeOfClothing = clothing.value(forKeyPath: "type") as? String
            guard let actualData = dataOfImage else {
                print("couldn't get data of image of clothing")
                return
            }
            guard let labelOfClothing = typeOfClothing else {
                print("couldn't get type of clothing")
                return
            }
            let imageOfClothing = UIImage(data: actualData)
            guard let actualImageOfClothing = imageOfClothing else {
                print("image couldn't be obtained")
                return
            }
            let imageView = UIImageView()
            
            let eachImage = actualImageOfClothing.rotate(radians: .pi/2)
            imageView.frame = CGRect(x: currX, y: currY, width: eachImage.size.width/10.0, height: eachImage.size.height/10.0)
            let label = UILabel()
            label.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + 1.0, width: widthL, height: heightL)
            
            imageView.image = eachImage
            
            label.text = labelOfClothing
            self.view.addSubview(imageView)
            self.view.addSubview(label)
            scrollView.addSubview(imageView)
            scrollView.addSubview(label)
            currY = label.frame.maxY + 10.0
        }
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: currY+100)
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
            AddClothingViewController.globalVariables.trying = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
