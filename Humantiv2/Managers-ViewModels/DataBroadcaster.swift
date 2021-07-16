//
//  DataBroadcaster.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import Foundation
import SwiftUI
import Combine

class DataBroadcaster: ObservableObject {
    //@Published var humantiveData: [HHData] = [HHData(type: "Heart Rate", value: 10, obsTime: Date()), HHData(type: "Steps", value: 10, obsTime: Date()), HHData(type: "Activity", value: 10, obsTime: Date()), HHData(type: "HRV", value: 5, obsTime: Date()), HHData(type: "Sleep", value: 10, obsTime: Date()), HHData(type: "Mood", value: 5, obsTime: Date()), HHData(type: "Mindfulness", value: 10, obsTime: Date()), HHData(type: "Glucose", value: 10, obsTime: Date()), HHData(type: "BP", value: 5, obsTime: Date()), HHData(type: "O2 Sat", value: 10, obsTime: Date())]
    @Published var humantiveData: [HHData] = []
    
    @Published var meditBalance = 9282
    @Published var meditText = "Medit Balance"
    @Published var mdxBalance = 10431
    @Published var mdxText = "MDX Balance"
    
    func normalizeHD2(hData: [HHData]) -> ([Double], [Color]) {
        var normArray: [Double] = []
        var colorArray: [Color] = []
        for item in hData {
            switch item.type {
            case "Heart Rate":
                if item.value < item.goalValue {
                    normArray.append(10.0)
                    colorArray.append(.green)
                } else {
                    normArray.append(7.0)
                    colorArray.append(.red)
                }
            default:
                if item.value >= item.goalValue {
                    normArray.append(10.0)
                    colorArray.append(.green)
                } else {
                    normArray.append(7.0)
                    colorArray.append(.red)
                }
            }
        }
        
        return (normArray, colorArray)
    }
    
    func normalizeHD() -> ([Double], [Color]) {
        var normArray: [Double] = []
        var colorArray: [Color] = []
        for item in humantiveData {
            switch item.type {
            case "Heart Rate":
                if item.value < item.goalValue {
                    normArray.append(10.0)
                    colorArray.append(.green)
                } else {
                    normArray.append(7.0)
                    colorArray.append(.red)
                }
            default:
                if item.value >= item.goalValue {
                    normArray.append(10.0)
                    colorArray.append(.green)
                } else {
                    normArray.append(7.0)
                    colorArray.append(.red)
                }
            }
        }
        
        return (normArray, colorArray)
    }
}
