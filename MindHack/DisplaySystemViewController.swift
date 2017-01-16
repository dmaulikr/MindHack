//
//  AddSystemViewController.swift
//  MindHack
//
//  Created by Bryan Ye on 15/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit
import SCLAlertView

class DisplaySystemViewController: UIViewController {
    
    var system: System?
    
    @IBOutlet weak var triggerTextField: UITextField!
    
    @IBOutlet weak var routineTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
        
        
        if let system = system {
            triggerTextField.text = system.trigger
            routineTextField.text = system.routine
        } else {
            triggerTextField.text = ""
            routineTextField.text = ""
        }
    }
    
    
    @IBAction func saveSystem(_ sender: UIBarButtonItem) {
        
        if triggerTextField.text == "" && routineTextField.text == "" {
            SCLAlertView().showError("Sorry", subTitle: "You haven't entered a trigger and routine")
        } else if triggerTextField.text == "" {
            SCLAlertView().showError("Sorry", subTitle: "You haven't entered a trigger")
        } else if routineTextField.text == "" {
            SCLAlertView().showError("Sorry", subTitle: "You haven't entered a routine")
        } else {
            let trigger = triggerTextField.text ?? ""
            let routine = routineTextField.text ?? ""
            
            
            if let system = system {
                CoreDataHelper.updateSystem(replace: system, newTrigger: trigger, newRoutine: routine)
            } else {
                CoreDataHelper.addSystem(trigger, routine: routine)
            }
            
            navigationController!.popViewController(animated: true)
        }
    }
    
    
}
