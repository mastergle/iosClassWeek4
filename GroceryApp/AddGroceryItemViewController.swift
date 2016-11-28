//
//  AddGroceryItemViewController.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

class AddGroceryItemViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField?
    @IBOutlet var quantityField: UITextField?
    
    let manager = DataManager.shared
    
    @IBAction func add() {
        try? manager.create(data: (nameField?.text, quantityField?.text?.integer ?? 0))
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }

}

extension String {
    var integer: Int? {
        return Int(self)
    }
}
