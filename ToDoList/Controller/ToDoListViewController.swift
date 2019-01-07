//
//  ViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 12/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray : [ChecklistItem] = [ChecklistItem]()
    var selectedCatagory : Catagory?
    {
        didSet
        {
            loadItems()
        }
    }
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            
            let newItem = ChecklistItem(context: self.context)
            newItem.title = textField.text!
            newItem.checked = false
            newItem.parentCatagory = self.selectedCatagory
            
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
        do
        {
            try context.save()
        }
        catch
        {
            print("Error")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<ChecklistItem> = ChecklistItem.fetchRequest())
    {
        do
        {
            let catogoryPredicate = NSPredicate(format: "parentCatagory.name MATCHES %@", selectedCatagory!.name!)
            
            if let predicate = request.predicate
            {
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogoryPredicate, predicate])
            }
            else
            {
                request.predicate = catogoryPredicate
            }
            
            itemArray = try context.fetch(request)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search bar
extension ToDoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let request : NSFetchRequest<ChecklistItem> = ChecklistItem.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONSTAINS[cd] %@",  searchBar.text!)
        
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request)
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

