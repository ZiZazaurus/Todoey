//
//  CategoryViewViewController.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/26/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Category.plist")
    
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()
    }
        
    //MARK: - TableView Datasource Methods
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell =  tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
            return cell
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return categories?.count ?? 1
        }
    
        //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //MARK: - Add New Categories

        
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        var textField = UITextField()
        
         let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
                }
        } catch {
            print("error saving to DataModel: \(error)")
        }
        
        self.tableView.reloadData()
    }

    func loadCategories() {
        
        categories = realm.objects(Category.self)
  
        tableView.reloadData()
    }
    
   
        
}
