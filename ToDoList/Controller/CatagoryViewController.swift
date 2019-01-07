//
//  CatagoryViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 18/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {

    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var catagories : [Catagory] = [Catagory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
    }

    @IBAction func AddCatagory(_ sender: UIBarButtonItem)
    {
        var textfield = UITextField()
        
        let view = UIAlertController(title: "Add Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create Catagory", style: .default) { (alert) in
            
            let newCatagory = Catagory(context: self.context)
            newCatagory.name = textfield.text!
            
            self.catagories.append(newCatagory)
            
            self.dismiss(animated: true, completion: nil)
            
            self.save()
        }
        
        view.addTextField { (UITextField) in
            UITextField.placeholder = "Create new catagory"
            
            textfield = UITextField
        }
        
        view.addAction(action)
        
        present(view, animated: true, completion: nil)
    }

    
    //MARK: Tableview stuff
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destVC.selectedCatagory = catagories[indexPath.row]
        }
        
    }
    
    //MARK: Load/Save
    
    func save()
    {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func load(with request: NSFetchRequest<Catagory> = Catagory.fetchRequest())
    {
        do {
            try catagories = context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
}
