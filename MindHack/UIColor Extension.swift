//
//  UIColor Extension.swift
//  MindHack
//
//  Created by Bryan Ye on 16/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit

extension UIColor {
    static func lightGrayBorder() -> UIColor {
        return UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 0.5)
    }
    
    static func mindHackBlue() -> UIColor {
        //2C40B0
        return UIColor(red: 44/255.0, green: 64/255.0, blue: 176/255.0, alpha: 1)
    }
    
    static func lighterMindHackBlue() -> UIColor {
        return UIColor(red: 44/255.0, green: 64/255.0, blue: 176/255.0, alpha: 0.8)
    }
    
    static func emptyDataBackgroundGray() -> UIColor {
        //F0F3F5
        return UIColor(red: 240/255.0, green: 243/255.0, blue: 245/255.0, alpha: 1)
    }
    
    
}
