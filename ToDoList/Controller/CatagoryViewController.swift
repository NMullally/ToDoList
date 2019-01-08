//
//  CatagoryViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 18/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    // results is a realm auto updating array, so dont need to append items to it,
    // if they are saved to realm itll auto update the container.
    var catagories : Results<Catagory>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
    }

    @IBAction func AddCatagory(_ sender: UIBarButtonItem)
    {
        var textfield = UITextField()
        
        let view = UIAlertController(title: "Add Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create Catagory", style: .default) { (alert) in
            
            
            let newCatagory = Catagory()
            newCatagory.name = textfield.text!
            
            self.dismiss(animated: true, completion: nil)
            
            self.save(with: newCatagory)
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
        
        cell.textLabel?.text = catagories?[indexPath.row].name ?? "No Catagorys"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories?.count ?? 1 // nil collesing operator
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destVC.selectedCatagory = catagories?[indexPath.row]
        }
    }
    
    //MARK: Load/Save
    
    func save(with catagory: Catagory)
    {
        do {
            try realm.write {
                realm.add(catagory)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func load()
    {
        catagories = realm.objects(Catagory.self)
        
        tableView.reloadData()
    }
}
