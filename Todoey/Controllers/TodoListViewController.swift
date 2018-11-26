//
//  ViewController.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/13/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    

    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            //Ternary operator ==>
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //Mark - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = todoItems?[indexPath.row] {
            do {
                
             try realm.write {
               item.done = !item.done
                }
            } catch {
                    print ("Error saving done status, \(error)")
                }
        }
        
        tableView.reloadData()
        
        
          tableView.deselectRow(at: indexPath, animated: true)
        
        }

    //Mark - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
   
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
        
            if let currentCategory = self.selectedCategory {
                do{
                    
                 try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    
                }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New To Do Item"
            textField = alertTextField
        }
        
            alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
        
    }
    
//    func saveItems () {
//
//        do {
//          try context.save()
//        } catch {
//          print("error saving context \(error)")
//
//        }
//
//        self.tableView.reloadData()
//    }
//
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    

}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}

