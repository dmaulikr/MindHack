//
//  AddSystemViewController.swift
//  MindHack
//
//  Created by Bryan Ye on 15/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit

class DisplaySystemViewController: UIViewController {
    
    var system: System?

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var isImportant: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let system = system {
            nameTextField.text = system.name
            isImportant.isOn = system.isImportant
        } else {
            nameTextField.text = ""
            isImportant.isOn = true
        }
    }

    
    @IBAction func addSystem(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let isImportant = self.isImportant.isOn
        
        if let system = system {
            CoreDataHelper.updateSystem(system, name: name, isImportant: isImportant)
        } else {
            CoreDataHelper.addSystem(name, isImportant: isImportant)
        }
        
        navigationController!.popViewController(animated: true)
    }
    
}
