//
//  SystemsViewController.swift
//  MindHack
//
//  Created by Bryan Ye on 15/1/17.
//  Copyright © 2017 Bryan Ye. All rights reserved.
//

import UIKit
import CoreData

class SystemsViewController: UIViewController {
    
    var systems = [System]()

    var systemToEdit: System?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }

    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            systems = try context.fetch(System.fetchRequest())
        } catch let error as NSError {
            print("Fetching failed: \(error)")
        }
    }

}

extension SystemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            let system = systems[indexPath.row]
            context.delete(system)
            
            appDelegate.saveContext()
            
            do {
                systems = try context.fetch(System.fetchRequest())
            } catch let error as NSError {
                print("Fetching failed: \(error)")
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.systemToEdit = systems[indexPath.row]
        self.performSegue(withIdentifier: "editSystem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSystem" {
            let destinationViewController = segue.destination as! DisplaySystemViewController
            if let systemToEdit = systemToEdit {
                destinationViewController.system = systemToEdit
            }
        }
        
    }
}

extension SystemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath)
        
        let system = systems[indexPath.row]
        cell.textLabel?.text = system.name!
        return cell
    }
    
}
