//
//  Constants.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/3/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import Foundation

//commented for debugging
//let kWorkTime = 120
let kWorkTime = 3

//commented for debugging
//let kBreakTime = 300
let kBreakTime = 5

let keyForSavedTasks = "UserSavedTasks"


//MARK:- Enum for state
enum TimerState {
    case RUNNING_TOMATO
    case RUNNING_BREAK
    case STOPPED
}

//MARK:- Color

let greenCustomColor = UIColor(red: 64/255.0, green: 206/255.0, blue: 126/255.0, alpha: 1.0) //#40CE7E
let redCustomColor = UIColor(red: 255/255.0, green: 116/255.0, blue: 126/255.0, alpha: 1.0) //#ff744f
