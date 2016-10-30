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
    
    @IBOutlet weak var soundFXBtn: CustomButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    
    @IBAction func breakTimeBtnPressed(_ sender: AnyObject) {
        
        AppDelegate().sharedInstance().settings.userBreakTime = Int(breakTimeLabel.text!)! * 60
        
    }
    
    @IBAction func workTimeBtnPressed(_ sender: AnyObject) {
        
        AppDelegate().sharedInstance().settings.userWorkTime = Int(workTimeLabel.text!)! * 60
        
    }

    @IBAction func soundFXToggle(_ sender: AnyObject) {
        
        if (AppDelegate().sharedInstance().settings.tickSoundOn == true) {
            AppDelegate().sharedInstance().settings.tickSoundOn = false
            self.soundFXBtn.setTitle("Turn On", for: UIControlState.normal)
            self.soundFXBtn.backgroundColor = redCustomColor
        } else {
            AppDelegate().sharedInstance().settings.tickSoundOn = true
            self.soundFXBtn.setTitle("Turn Off", for: UIControlState.normal)
            self.soundFXBtn.backgroundColor = greenCustomColor
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsDone(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    


}
