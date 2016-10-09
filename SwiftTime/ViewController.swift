//
//  ViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/3/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit
import pop

class ViewController: UIViewController {

    @IBOutlet weak var countdownDisplay: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var animEngine: AnimationEngine!
    
    var timeCard: Card!
    
    var currentState: TimerState!
    
    @IBOutlet weak var startButtonConstraint: NSLayoutConstraint!

    var timer: Timer?
    
    var remainingTicks: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [startButtonConstraint])
        currentState = TimerState.STOPPED        
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animEngine.animateOnScreen()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.animEngine = AnimationEngine(constraints: [startButtonConstraint])

    }
 
    //MARK:- Setup Funcs
    
    func initialSetup()
    {
        remainingTicks = kWorkTime
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
        if ((timer) != nil) {
            return
        }
        currentState = .RUNNING_TOMATO
        timeCard = Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as! Card!
        timeCard.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(timeCard)
        timeCard.countdownLabel.text = "Work!"
        self.animEngine.animateToPosition(view: self.timeCard, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation?, finished: Bool) -> Void
            in
            self.updateDisplay()
            self.startCountdown()
            })
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
        
        if (remainingTicks == 0) {
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
        remainingTicks = kBreakTime
        timeCard.countdownLabel.text = "Break!"
        currentState = TimerState.RUNNING_BREAK
        promptUserForTaskEntry()
    }
    
    func transitionToStop()
    {
        remainingTicks = kWorkTime
        currentState = TimerState.STOPPED
        updateDisplay()
        self.animEngine.animateToPosition(view: self.timeCard, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation?, finished: Bool) -> Void
            in
        })
    }
    
    func promptUserForTaskEntry()
    {
        let alertController = UIAlertController(title: "Add New Task", message: "What did you do?", preferredStyle: UIAlertControllerStyle.alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            
            self.saveTask(taskToSave: (alertController.textFields?.first?.text)!)
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
        print("The task to save is \(taskToSave)")
        let delegate : AppDelegate = AppDelegate().sharedInstance()
        delegate.completedTomatoes.append(taskToSave)
        delegate.saveTasks(completedTasks: delegate.completedTomatoes)
    }

}

