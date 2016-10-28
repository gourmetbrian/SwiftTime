//
//  TaskDetailViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/7/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var textOfLabel: RoundLabel!
    
    @IBOutlet weak var textOfTaskLabel: RoundLabel!
    
    var labelText = ""
    var activeRow = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textOfTaskLabel.text = activeRow
        textOfLabel.text = labelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
    @IBAction func detailDone(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
