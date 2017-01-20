//
//  Global Functions.swift
//  MindHack
//
//  Created by Bryan Ye on 20/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit

//Checks if Open Sans Font exists

func doesOpenSansExist() -> Bool {
    print(UIFont.fontNames(forFamilyName: "Open Sans"))
    
    let fontFamilies = UIFont.familyNames
    if fontFamilies.contains("Open Sans") {
        let fontNames = UIFont.fontNames(forFamilyName: "Open Sans")
        if fontNames.contains("OpenSans") {
            return true
        }
    }
    
    return false
}
