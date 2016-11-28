//
//  UIViewController+Extension.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @IBAction func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dimissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func dimissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dimissKeyboard() {
        view.endEditing(true)
    }
}
