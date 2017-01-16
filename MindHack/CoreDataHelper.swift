//
//  CoreDataHelper.swift
//  MindHack
//
//  Created by Bryan Ye on 15/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addSystem(_ name: String, isImportant: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = getContext()
        
        let system = System(context: context)
        system.name = name
        system.isImportant = isImportant
        
        appDelegate.saveContext()

    }
    
    static func updateSystem(_ oldSystem: System, name: String, isImportant: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        oldSystem.name = name
        oldSystem.isImportant = isImportant
        
        appDelegate.saveContext()
    }
}
