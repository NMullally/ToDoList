//
//  ViewController.swift
//  ToDoList
//
//  Created by Niall Mullally on 12/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Hello", "Goodbye", "Alveduasway"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) \(itemArray[indexPath.row])")
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = cell?.accessoryType == .checkmark ? .none : .checkmark

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

