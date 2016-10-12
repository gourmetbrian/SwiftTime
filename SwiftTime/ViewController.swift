//
//  ViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/3/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit
import pop
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var countdownDisplay: UILabel!
    
    @IBOutlet weak var startButton: CustomButton!
    
    @IBOutlet weak var goToSettingsBtn: CustomButton!
    
    @IBOutlet weak var goToTaskListBtn: CustomButton!
    
    var animEngine: AnimationEngine!
    
    var timeCard: Card!
    
    var currentState: TimerState!
    
    @IBOutlet weak var settingsButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startButtonConstraint: NSLayoutConstraint!

    @IBOutlet weak var taskButtonConstraint: NSLayoutConstraint!
    
    var timer: Timer?
    
    var remainingTicks: Int = 0
    
    let tickPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: "tick", ofType: "caf")!)
    
    let alarmPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "caf")!)
    
    var player: AVAudioPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [startButtonConstraint, settingsButtonConstraint,taskButtonConstraint])
        currentState = TimerState.STOPPED        
        initialSetup()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
            animEngine.animateOnScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK:- Setup Funcs
    
    func initialSetup()
    {
        remainingTicks = AppDelegate().sharedInstance().settings.userWorkTime
    }
    
    func updateDisplay()
    {
            let mins: String = String(format: "%02d", remainingTicks / 60)
            let secs: String = String(format: "%02d", remainingTicks % 60)
            timeCard.countdownLabel.text = mins + ":" + secs
    }
    
    //MARK:- Button Actions
    
    @IBAction func startTomatoPressed(_ sender: AnyObject)
    {

        if (currentState == .STOPPED ) {
        remainingTicks = 3 //AppDelegate().sharedInstance().settings.userWorkTime
        currentState = .RUNNING_TOMATO
        self.goToSettingsBtn.isEnabled = false
        self.goToSettingsBtn.alpha = 0.4
        self.goToTaskListBtn.isEnabled = false
        self.goToTaskListBtn.alpha = 0.4
        timeCard = Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as! Card!
        timeCard.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(timeCard)
        timeCard.countdownLabel.text = "Work!"
        self.animEngine.animateToPosition(view: self.timeCard, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation?, finished: Bool) -> Void
            in
            self.updateDisplay()
            self.startCountdown()
            })
        } else if (currentState == .RUNNING_TOMATO || currentState == .RUNNING_BREAK) {
            timer?.invalidate()
            timer = nil
            transitionToStop()
        }
    }
    
    //MARK:- Timer Functions
    func startCountdown()
    {
        if (timer != nil) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
    }
    
    func decreaseTimer()
    {
        remainingTicks -= 1
        updateDisplay()
        
        startButton.scaleAnimation()
        if (AppDelegate().sharedInstance().settings.tickSoundOn == true) {
        playMyFile(fileToPlay: tickPath)
        }

        
        if (remainingTicks == 0) {
            if (AppDelegate().sharedInstance().settings.tickSoundOn == true) {
            playMyFile(fileToPlay: alarmPath)
            }
            timer?.invalidate()
            timer = nil
            if (currentState == TimerState.RUNNING_TOMATO) {
                self.transitionToBreak()
            } else if (currentState == TimerState.RUNNING_BREAK) {
                self.transitionToStop()
            }
        }
    }
    
    //MARK:- State Transitions
    
    func transitionToBreak()
    {
        remainingTicks = AppDelegate().sharedInstance().settings.userBreakTime
        timeCard.countdownLabel.text = "Break!"
        currentState = TimerState.RUNNING_BREAK
        promptUserForTaskEntry()
    }
    
    func transitionToStop()
    {
        remainingTicks = 0
        currentState = TimerState.STOPPED
        updateDisplay()
        self.animEngine.animateToPosition(view: self.timeCard, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation?, finished: Bool) -> Void
            in
            self.goToSettingsBtn.isEnabled = true
            self.goToSettingsBtn.alpha = 1.0
            self.goToTaskListBtn.isEnabled = true
            self.goToTaskListBtn.alpha = 1.0
        })
    }
    
    func promptUserForTaskEntry()
    {
        let alertController = UIAlertController(title: "Add New Task", message: "What did you do?", preferredStyle: UIAlertControllerStyle.alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            
            if let task = alertController.textFields?.first?.text {
                self.saveTask(taskToSave: "\(self.createTimeStamp()) - \(task)")
            }
            self.updateDisplay()
            self.startCountdown()
            alertController.dismiss(animated: true, completion: {
            })
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Worked on reports..."
        }
        alertController.addAction(submitAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveTask(taskToSave: String)
    {
        let delegate : AppDelegate = AppDelegate().sharedInstance()
        delegate.completedTomatoes.append(taskToSave)
        delegate.saveTasks(completedTasks: delegate.completedTomatoes)
    }
    
    func playMyFile(fileToPlay: NSURL)
    {
        do {
            try player =  AVAudioPlayer(contentsOf: fileToPlay as URL)
        } catch {
            print("error playing file")
        }
        player?.prepareToPlay()
        player?.play()
    }
    
    func createTimeStamp() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.short
        
        return formatter.string(from: date)
    }

}

