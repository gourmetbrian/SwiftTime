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
