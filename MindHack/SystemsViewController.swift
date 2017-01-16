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
    
    let tableViewCellNibName = "SystemsTableViewCell"
    
    var systems = [System]()

    var systemToEdit: System?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }

}

extension SystemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let system = systems[indexPath.row]
            CoreDataHelper.deleteSystem(system)
            
            systems = CoreDataHelper.fetchSystems()
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
        let cell = Bundle.main.loadNibNamed(tableViewCellNibName, owner: self, options: nil)?.first as! SystemsTableViewCell
        
        let system = systems[indexPath.row]
        cell.triggerLabel?.text = system.name!
        return cell
    }
    
}
