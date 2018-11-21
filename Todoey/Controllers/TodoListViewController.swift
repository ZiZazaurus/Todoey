//
//  ViewController.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/13/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Get Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demagorgon"
        itemArray.append(newItem3)
        
    if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        itemArray = items
          }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Mark - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
            tableView.reloadData()
        
          tableView.deselectRow(at: indexPath, animated: true)
        
        }

    //Mark - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
   
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New To Do Item"
            textField = alertTextField
        }
        
            alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    }



