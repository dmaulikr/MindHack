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
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a trigger and routine")
        } else if triggerTextField.text == "" {
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a trigger")
        } else if routineTextField.text == "" {
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a routine")
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
    
    func alertUserOfError(title: String, subTitle: String) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showError(title, subTitle: subTitle)
    }
    
    
}
