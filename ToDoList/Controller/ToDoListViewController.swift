//
//  ViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 12/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    let realm = try! Realm()
    
    var items : Results<Item>?
    var selectedCatagory : Catagory?
    {
        didSet
        {
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        if let item = items?[indexPath.row]
        {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark :  .none
        }
        else
        {
            cell.textLabel?.text = "Empty"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) \(String(describing: items?[indexPath.row]))")
        
        if let item = items?[indexPath.row]
        {
            do
            {
                try realm.write {
                    item.done = !item.done
                }
            }
            catch
            {
                print("Error writing to realm in didSelectRowAt")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func AddItem(_ sender: Any)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCatagory = self.selectedCatagory
            {
                do
                {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.done = false
                        newItem.date = Date()
                        
                        currentCatagory.items.append(newItem)
                    }
                }
                catch
                {
                    print("Error writing to realm in add item")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (actionTextField) in
            textField.placeholder = "Create new Item"
            
            textField = actionTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems()
    {
        items = selectedCatagory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}

//MARK: - Search bar
extension ToDoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems()
            
            DispatchQueue.main.async {
                // means its not longer being edited // shouldnt be selected
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

