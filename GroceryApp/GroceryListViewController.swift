//
//  ViewController.swift
//  GroceryApp
//
//  Created by Barry, Elh on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

protocol SelectedItemViewController {
    var selectedItemIndex : Int? {get set}
}

class GroceryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var groceryListTableView: UITableView?
    
    var manager = DataManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.loadGroceryListData()
        groceryListTableView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if var destination = segue.destination as? SelectedItemViewController {
            destination.selectedItemIndex = groceryListTableView?.indexPathForSelectedRow?.row
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryListsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let list = manager.getGroceryList(from: indexPath)
        cell.textLabel?.text = list?.name
        cell.detailTextLabel?.text = "\(list?.itemCount ?? 0) Items"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        
        manager.selectedGroceryListIndex = indexPath.row
    }
}

