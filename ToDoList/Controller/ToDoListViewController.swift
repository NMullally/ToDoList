//
//  ViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 12/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray : [ChecklistItem] = [ChecklistItem]()
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemArray +=    ([ChecklistItem("First"),
                         ChecklistItem("Second"),
                         ChecklistItem("Third")])
        
        loadItems()
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].checked ? .checkmark :  .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) \(itemArray[indexPath.row])")
        
        let item = itemArray[indexPath.row]
        
        item.checked = !item.checked
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func AddItem(_ sender: Any)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = ChecklistItem(textField.text!)
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (actionTextField) in
            textField.placeholder = "Create new Item"
            
            textField = actionTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do
        {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }
        catch
        {
            print("Error")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems()
    {
        do
        {
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            
            itemArray = try decoder.decode([ChecklistItem].self, from: data)
        }
        catch{
            
        }
    }
    
}

