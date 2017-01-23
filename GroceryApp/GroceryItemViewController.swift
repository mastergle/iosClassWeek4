//
//  GroceryItemViewController.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

class GroceryItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SelectedItemViewController {

    @IBOutlet var groceryItemTableView: UITableView?
    var selectedItemIndex: Int?
    
    let manager = DataManager.shared
    
    var state: TableState = .normal
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.loadGroceryItem()
        groceryItemTableView?.reloadData()
    }
    
    // MARK: - Table View
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryItemsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = manager.getGroceryItem(from: indexPath)
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = "Quantity: \(item?.quantity ?? 0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        
        if let selectedIndex = selectedItemIndex {
            manager.selectedGroceryItemIndex = selectedIndex
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteRow(at: indexPath)
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        try? manager.deleteGroceryItem(from: indexPath)
        groceryItemTableView?.reloadData()
    }
}
