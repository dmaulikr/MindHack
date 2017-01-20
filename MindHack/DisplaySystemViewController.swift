//
//  AddSystemViewController.swift
//  MindHack
//
//  Created by Bryan Ye on 15/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit
import SCLAlertView
import SkyFloatingLabelTextField

class DisplaySystemViewController: UIViewController {
    
    var system: System?
    
    
    var triggerTextField: SkyFloatingLabelTextField?
    var routineTextField: SkyFloatingLabelTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupLogoImageView()
        
    }
    
    let logoImage: UIImageView = {
        let image = UIImage(named: "EmptyDataLogo")
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupLogoImageView() {
        view.addSubview(logoImage)
        
        logoImage.bottomAnchor.constraint(equalTo: (triggerTextField?.topAnchor)!, constant: -20).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DisplaySystemViewController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DisplaySystemViewController.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupTextFields() {
        
        let textFieldWidth: CGFloat = 250
        let textFieldHeight: CGFloat = 45
        let textFieldSize = CGSize(width: textFieldWidth, height: textFieldHeight)
        
        let middleOfScreenX = view.frame.origin.x + view.frame.size.width/2
        let middleOfScreenY = view.frame.origin.y + view.frame.size.height/2
        
        let triggerTextFieldPoint = CGPoint(x:  middleOfScreenX - textFieldWidth/2, y:  middleOfScreenY - textFieldHeight/2 - 25)

        let routineTextFieldPoint = CGPoint(x:  middleOfScreenX - textFieldWidth/2, y:  middleOfScreenY - textFieldHeight/2 + 25)

        let triggerTextFieldRect = CGRect(origin: triggerTextFieldPoint, size: textFieldSize)
        triggerTextField = SkyFloatingLabelTextField(frame: triggerTextFieldRect)
        triggerTextField?.placeholder = "Trigger"
        triggerTextField?.title = "Trigger"
        triggerTextField?.tintColor = .yellow
        triggerTextField?.selectedTitleColor = .cyan
        triggerTextField?.selectedLineColor = .cyan
        triggerTextField?.textColor = .white
        
        let routineTextFieldRect = CGRect(origin: routineTextFieldPoint, size: textFieldSize)
        routineTextField = SkyFloatingLabelTextField(frame: routineTextFieldRect)
        routineTextField?.placeholder = "Routine"
        routineTextField?.title = "Routine"
        routineTextField?.tintColor = .yellow
        routineTextField?.selectedTitleColor = .cyan
        routineTextField?.selectedLineColor = .cyan
        routineTextField?.textColor = .white
        
        
        guard triggerTextField != nil else {
            print("Error producing triggerTextField")
            return
        }
        
        guard routineTextField != nil else {
            print("Error producing routineTextField")
            return
        }
        
        triggerTextField?.delegate = self
        routineTextField?.delegate = self
        
        if let system = system {
            triggerTextField?.text = system.trigger
            routineTextField?.text = system.routine
        } else {
            triggerTextField?.text = ""
            routineTextField?.text = ""
        }
        
        self.view.addSubview(triggerTextField!)
        self.view.addSubview(routineTextField!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func saveSystem(_ sender: UIBarButtonItem) {
        
        
        if triggerTextField?
            .text == "" && routineTextField?.text == "" {
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a trigger and routine")
        } else if triggerTextField?.text == "" {
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a trigger")
        } else if routineTextField?.text == "" {
            alertUserOfError(title: "Sorry", subTitle: "You haven't entered a routine")
        } else {
            let trigger = triggerTextField?.text ?? ""
            let routine = routineTextField?.text ?? ""
            
            
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
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height)
            }
        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
}

extension DisplaySystemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
