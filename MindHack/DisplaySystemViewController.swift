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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
