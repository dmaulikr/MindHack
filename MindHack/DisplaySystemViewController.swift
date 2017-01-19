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
            kTitleFont: UIFont(name: "OpenSans", size: 20)!,
            kTextFont: UIFont(name: "OpenSans", size: 14)!,
            kButtonFont: UIFont(name: "OpenSans-Semibold", size: 14)!,
            showCloseButton: true,
            contentViewColor: UIColor.white
            
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewAnimationStyle = SCLAnimationStyle.noAnimation
        let alertViewIcon = UIImage(named: "EmptyDataLogo")
        
        alertView.showInfo(title, subTitle: subTitle, closeButtonTitle: "Done", duration: 0, colorStyle: 0x2C40B0, circleIconImage: alertViewIcon, animationStyle: alertViewAnimationStyle)
    }
    
    
}
