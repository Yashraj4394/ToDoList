//
//  ViewController.swift
//  ToDoList
//
//  Created by YashraJ Gujar on 25/03/19.
//  Copyright © 2019 YashraJ. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    let itemArray = ["Search For iOS Internships","Eat Apples","Exercise for 15 mins","Take a nap for 15 mins"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
//MARK : TablevIew DataSource Methods -
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
        //MARK - Table View Delegate Methods
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)

    }

    
}

