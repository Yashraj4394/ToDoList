//
//  ViewController.swift
//  ToDoList
//
//  Created by YashraJ Gujar on 25/03/19.
//  Copyright © 2019 YashraJ. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()// itemArray will be array of Item objects. ()This has been used to initialize the array
    var selectedCategory : Category? {
        didSet {
            loadItems()

        }
    }
    
    let newContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    // MARK: - TablevIew DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary Operator ->
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ?  .checkmark : .none
        
        return cell
        
        // MARK: - Table View Delegate Methods
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            //  alertTextField.clearsOnInsertion = false
            textField = alertTextField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item(context: self.newContext)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        do {
            try newContext.save()
        }catch {
            print("Error Saving Context\(error)")
            
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil ) { // with is the external parameter and request is the internal parameter that is of type NSFetchRequest.  Item.fetchRequest() is the default value for the load items function. So what when we call the function in viewDidLoad , we dont have to provide any values. It will just fetch all items in the data.
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        let Categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [Categorypredicate,additionalPredicate])
        } else {
             request.predicate = Categorypredicate
        }
        
        do {
            itemArray =  try newContext.fetch(request) // here we dont need to use save context method as here we are only fetching the data and now updating the data.
        }
        catch {
            print("Error Loading Items\(error)")
        }
        tableView.reloadData()
        
    }
    
    
    
}//class ends

// MARK: - SearchBar Methods

extension ToDoListViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors  = [NSSortDescriptor(key: "title", ascending: true)]
        tableView.reloadData()
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tableView.reloadData()
        }
}
}
