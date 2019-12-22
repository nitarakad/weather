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
    var allClothing: Array<UIImage> = []
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {

    }
    
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let imageTaken = info[.originalImage] as? UIImage {
            allClothing.append(imageTaken)
        }
        imageView.image = info[.originalImage] as? UIImage
    }
}
