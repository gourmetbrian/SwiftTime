//
//  SettingsViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/9/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var workTimeLabel: UITextField!
    
    @IBOutlet weak var setBreakTimeBtn: CustomButton!
    
    @IBOutlet weak var setWorkTimeBtn: CustomButton!
        
    @IBOutlet weak var breakTimeLabel: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func breakTimeBtnPressed(_ sender: AnyObject) {
        
        AppDelegate().sharedInstance().settings.userBreakTime = Int(breakTimeLabel.text!)! * 60
        
    }
    
    @IBAction func workTimeBtnPressed(_ sender: AnyObject) {
        
        AppDelegate().sharedInstance().settings.userWorkTime = Int(workTimeLabel.text!)! * 60
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
