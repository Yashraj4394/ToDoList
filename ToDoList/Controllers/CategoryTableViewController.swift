//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by YashraJ Gujar on 27/03/19.
//  Copyright © 2019 YashraJ. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let newContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // this method will be called before peformSeque.
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPaths = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPaths.row] 
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Category(context: self.newContext)
            newItem.name = textField.text!
            self.categoryArray.append(newItem)
            self.save()
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Data Manipulation Methods 
    func save() {
        do {
            try newContext.save()
        } catch {
            print("Error Saving Data\(error)")
        }
        tableView.reloadData()
    }
    
    func load(with request:NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try newContext.fetch(request)
        } catch {
            print("Error Loading Data\(error)")
        }
       tableView.reloadData()
    }
    
}
