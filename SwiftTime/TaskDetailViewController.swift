//
//  TaskDetailViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/7/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    var activeRow = ""
    var labelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = activeRow
        label.text = labelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func detailDone(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
