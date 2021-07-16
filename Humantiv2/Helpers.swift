//
//  Helpers.swift
//  Humantiv2
//
//  Created by Mark Pruit on 6/23/21.
//

import Foundation
import SwiftUI
import HealthKit

class Helpers {
    //***********************Data Normalization******************************************
    static func normalizeHealthArray(healthValuesArray: [Double], completion: @escaping ([Double]) -> Void) {
        let sourceArray = healthValuesArray
        guard let min = sourceArray.min() else {return}
        guard let max = sourceArray.max() else {return}
        let results = sourceArray.map { ($0 - min) / (max - min) }
        completion(results)
    }
    
    static func normalizeHealthDataArray(healthValuesArray: [Double]) -> [CGFloat] {
        let sourceArray = healthValuesArray
        guard let min = sourceArray.min() else {return []}
        guard let max = sourceArray.max() else {return []}
        let results = sourceArray.map { ($0 - min) / (max - min) }
        let cgArray = results.map {CGFloat($0)}
        return cgArray
    }
    
    static func normalizeDiastolicArray(healthValuesArray: [Double], sysMax: Double, completion: @escaping ([Double]) -> Void) {
        let sourceArray = healthValuesArray
        guard let min = sourceArray.min() else {return}
        let max = sysMax
        let results = sourceArray.map { ($0 - min) / (max - min) }
        completion(results)
    }
    
    //***** Time interval functions
    //for HealthKit sample time interval
    static func calculateTotalTime(sample: HKSample) -> TimeInterval {
        let totalTime = sample.endDate.timeIntervalSince(sample.startDate)
        let wasUserEntered = sample.metadata?[HKMetadataKeyWasUserEntered] as? Bool ?? false
        
        print("\nHealthkit mindful entry: \(sample.startDate) \(sample.endDate) - value: \(totalTime) quantity: \(totalTime) user entered: \(wasUserEntered)\n")
        
        return totalTime
    }
    
    static func timeDifferences(time1: Date, time2: Date, completion: @escaping (Int, Int, Int) -> Void) {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: time1, to: time2)
        guard let hours = diffComponents.hour else {return}
        guard let minutes = diffComponents.minute else {return}
        guard let seconds = diffComponents.second else {return}
        
        completion(hours, minutes, seconds)
        
    }
}
