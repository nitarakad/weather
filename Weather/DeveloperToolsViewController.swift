//
//  DeveloperToolsViewController.swift
//  Weather
//
//  Created by Nitya Tarakad on 12/25/19.
//  Copyright © 2019 Nitya Tarakad. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DeveloperToolsViewController: UITableViewController {
    
    var developerButtons: [UIButton] = []
    var currButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtons()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developerButtons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sizeOfButton = CGRect(x: 0.75 * cell.frame.midX, y: cell.frame.minY, width: cell.frame.midX, height: cell.frame.maxY - cell.frame.minY)
        developerButtons[currButton].frame = sizeOfButton
        cell.addSubview(developerButtons[currButton])
        self.view.addSubview(cell)
        currButton = currButton + 1
        return cell
    }
    
    func addButtons() {
        let clearAllClothingButton = UIButton()
        clearAllClothingButton.backgroundColor = .blue
        clearAllClothingButton.setTitle("Clear All Clothing", for: .normal)
        clearAllClothingButton.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
        developerButtons.append(clearAllClothingButton)
    }
    
    @objc func clicked(_ sender: UIButton) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clothing")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
            print("Delete at data in Clothing error: \(error)")
        }
        print("clear all clothing button selected")
    }
    
    
    
    
    
}
