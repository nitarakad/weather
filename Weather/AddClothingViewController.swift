//
//  AddClothingViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/19/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddClothingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    struct globalVariables {
        static var allClothing = Array<NSManagedObject>()
    }
    
    @IBOutlet weak var addClothingButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imagePicker: UIImagePickerController!
    var currentImage = UIImage()
    var resetToPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        inputTextField.isEnabled = false
        
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
        inputTextField.isEnabled = true
        inputTextField.text = ""
        currentImage = imageTaken
    }
}

extension AddClothingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        scrollView.setContentOffset(resetToPoint, animated: true)
        if let length = inputTextField.text?.count, length > 0 {
            
            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
                print("app delegate not working after text field inputted")
                return false
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let asData = currentImage.pngData()
            for clothing in globalVariables.allClothing {
                let dataClothing = clothing.value(forKeyPath: "image") as? Data
                if let asDataActual = asData, let dataClothingActual = dataClothing, asDataActual == dataClothingActual {
                    clothing.setValue(inputTextField.text, forKey: "type")
                }
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("couldn't save. \(error), \(error.userInfo)")
            }
        }
        inputTextField.isEnabled = false
        
        addClothingButton.setTitle("Add Another Clothing!", for: .normal)
        
        print("user hit return button")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetToPoint = self.view.frame.origin
        var point = inputTextField.frame.origin
        point.y = point.y - 5
        scrollView.setContentOffset(point, animated: true)
        print("user begins editing text field")
    }
}
