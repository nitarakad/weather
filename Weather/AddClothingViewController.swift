//
//  AddClothingViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/19/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation
import UIKit

class AddClothingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    //let inputText = UITextField()
    var currentImage = UIImage()
    
    struct globalVariables {
        static var allClothing: Array<UIImage> = []
        static var clothingDict = Dictionary<UIImage, String>()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        inputTextField.isEnabled = false
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
        globalVariables.allClothing.append(imageTaken)
        imageView.image = imageTaken
        inputTextField.isEnabled = true
        currentImage = imageTaken
    }
}

extension AddClothingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        if let length = inputTextField.text?.count, length > 0 {
            globalVariables.clothingDict[currentImage] = inputTextField.text
        }
        inputTextField.isEnabled = false
        print("user hit return button")
        return true
    }
}
