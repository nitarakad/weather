//
//  AddClothingViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/19/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

/*
 In this View Controller, the user should be able to add pictures of their clothing
 The user should be able to label what type of clothing they have added as well
 */

import Foundation
import UIKit
import CoreData


class AddClothingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    struct globalVariables {
        static var allClothing = Array<NSManagedObject>()
    }
    
    @IBOutlet weak var addClothingButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var imagePicker: UIImagePickerController!
    var currentImage = UIImage()
    var resetToPoint = CGPoint()
    
    let clothingOptions = ["t-shirt", "shorts", "pants", "jacket", "dress", "long sleeve"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        
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
            globalVariables.allClothing = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let imageTaken = info[.originalImage] as? UIImage else {
            print("no image")
            return
        }
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let asData = imageTaken.pngData()
        let entity = NSEntityDescription.entity(forEntityName: "Clothing", in: managedContext)!
        let clothing = NSManagedObject(entity: entity, insertInto: managedContext)
        clothing.setValue(asData, forKey: "image")
        
        do {
            try managedContext.save()
            globalVariables.allClothing.append(clothing)
        } catch let error as NSError {
            print("couldn't save. \(error), \(error.userInfo)")
        }
        
        imageView.image = imageTaken
        pickerView.isUserInteractionEnabled = true
        currentImage = imageTaken
    }
}

extension AddClothingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clothingOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clothingOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("what was selected: \(clothingOptions[row])")
        let clothingOption = clothingOptions[row]
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            print("app delegate not working after picker view option selected")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let asData = currentImage.pngData()
        for clothing in globalVariables.allClothing {
            let dataClothing = clothing.value(forKeyPath: "image") as? Data
            if let asDataActual = asData, let dataClothingActual = dataClothing, asDataActual == dataClothingActual {
                clothing.setValue(clothingOption, forKey: "type")
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("couldn't save. \(error), \(error.userInfo)")
        }
        
        pickerView.isUserInteractionEnabled = false
        
        addClothingButton.setTitle("Add Another Clothing!", for: .normal)
        
        print("user selected option")
        return
        
    }
}
