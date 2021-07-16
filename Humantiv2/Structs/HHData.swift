//
//  HumantiveHealthData.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import Foundation
import Combine

struct HHData: Hashable {
    var id = UUID()
    var type = ""
    var value = 0.0
    var goalValue = 0.0
    var units = ""
    var valueArray: [Double] = []
    var obsTime = Date()
}

struct MindfulStruct {
    var date = Date()
    var value = 0.0
}

struct SleepStruct {
    var date = Date()
    var value = 0.0
}


