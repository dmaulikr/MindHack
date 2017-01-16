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
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addSystem(_ trigger: String, routine: String) {

        let context = getContext()
        
        let system = System(context: context)
        system.trigger = trigger
        system.routine = routine
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Saving failed while adding system: \(error.localizedDescription)")
        }

    }
    
    static func updateSystem(replace oldSystem: System, newTrigger: String, newRoutine: String) {
        
        let context = getContext()
        
        oldSystem.trigger = newTrigger
        oldSystem.routine = newRoutine
        
        

        do {
          try context.save()
        } catch let error as NSError {
            print("Saving failed while updating system: \(error.localizedDescription)")
        }
    }
    
    static func deleteSystem(_ system: System) {
        
        let context = getContext()
        
        context.delete(system)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Saving failed while deleting system: \(error.localizedDescription)")
        }
    }
    
    static func fetchSystems() -> [System] {
        
        var systems = [System]()
        
        let context = getContext()
        
        do {
            systems = try context.fetch(System.fetchRequest())
        } catch let error as NSError {
            print("Fetching failed: \(error.localizedDescription)")
        }
        
        return systems
    }
}
