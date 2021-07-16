//
//  ActivityLog.swift
//  StravaGraph
//
//  Created by Mark Pruit on 3/25/21.
//

import Foundation
import SwiftUI


struct ActivityLog {
 var value: Double
 var date: Date
 //var logType = [Color(red: 251/255, green: 82/255, blue: 0), .white]
 var lg = [Color(red: 251/255, green: 82/255, blue: 0), .white]
}
/*
struct ActivityLog {
    var distance: Double // Miles
    var duration: Double // Seconds
    var elevation: Double // Feet
    var date: Date
    var lg = [Color(red: 251/255, green: 82/255, blue: 0), .white]
}*/

struct HeartRateLog {
    var value: Double
    var date: Date
    var logType = "hrLog"
}

struct ActiveEnergyLog {
    var value: Double
    var date: Date
    var logType = "aeLog"
}

struct StepsLog {
    var value: Double
    var date: Date
    var logType = "stepsLog"
}

struct HrvLog {
    var value: Double
    var date: Date
    var logType = "hrvLog"
}
