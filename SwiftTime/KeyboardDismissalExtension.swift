//
//  KeyboardDismissalExtension.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/21/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
