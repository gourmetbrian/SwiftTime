//
//  Settings.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/9/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class Settings {
    
    let DEFAULT_WORK_TIME = 1500
    let DEFAULT_BREAK_TIME = 300
    var userWorkTime: Int = 0
    var userBreakTime: Int = 0
    var tickSoundOn = false

    init()
    {
        userWorkTime = DEFAULT_WORK_TIME
        userBreakTime = DEFAULT_BREAK_TIME
    }
    
}
