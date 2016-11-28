//
//  AddGroceryListViewController.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

class AddGroceryListViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField?
    
    var manager = DataManager.shared
    
    @IBAction func add() {
        try? manager.create(groceryListNamed: nameField?.text)
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}
