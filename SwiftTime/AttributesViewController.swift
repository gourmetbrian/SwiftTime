//
//  AttributesViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/16/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class AttributesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func attributesDone(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
