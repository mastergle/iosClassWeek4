//
//  ViewController.swift
//  GroceryApp
//
//  Created by Barry, Elh on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

enum TableState {
    case editing
    case normal
    
    var value: (isEditing: Bool, title: String) {
        switch self {
        case .normal:
            return (false, "Edit")
        case .editing:
            return (true, "Done")
        }
    }
    
    var opposite: TableState {
        switch self {
        case .normal:
            return .editing
        case .editing:
            return .normal
        }
    }
}

protocol SelectedItemViewController {
    var selectedItemIndex : Int? {get set}
}

class GroceryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var groceryListTableView: UITableView?
    
    var manager = DataManager.shared
    
    var state: TableState = .normal
    
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
    
    // MARK: - Actions
    
    @IBAction func edit(sender: UIBarButtonItem) {
        state = state.opposite
        groceryListTableView?.setEditing(state.value.isEditing, animated: UIView.areAnimationsEnabled)
        sender.title = state.value.title
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryListsCount
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let list = manager.getGroceryList(from: indexPath)
        cell.textLabel?.text = list?.name
        cell.detailTextLabel?.text = "\(list?.itemCount ?? 0) Items"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        manager.selectedGroceryListIndex = indexPath.row
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
        try? manager.deleteGroceryList(from: indexPath)
        groceryListTableView?.reloadData()
    }
}

