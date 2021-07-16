//
//  HomeViewModel.swift
//  Humantiv2
//
//  Created by Mark Pruit on 6/23/21.
//

import Foundation
import Combine
import HealthKit
import SwiftUI

class HomeViewModel: ObservableObject {
    /*
    let formatter = DateFormatter()
    let timeFormatter = DateFormatter()
    @Published var db: DataBroadcaster
    @Published var hkm: HealthKitManager
    @Published var showHGraph = false
    @Published var hScore = 0
    @State var circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .green, .green, .green]), startPoint: .top, endPoint: .bottom)
    
    func startItUp() {
        hkm.requestPermissions()
        
        formatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
        
        var interval = DateComponents()
        interval.day = 1
        
        let startDate = Date().addingTimeInterval(86400 * 7 * -1)
        
        print(startDate)
        
        db.humantiveData = []
        showHGraph = false
        
        //Enter the dispatch group ring
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        hkm.statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRate, units: hkm.heartRateQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Heart Rate", value: valuesAvgArray.last ?? 0, goalValue: 76.0, units: "bpm", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.db.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        hkm.statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .stepCount, units: hkm.stepsQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Steps", value: valuesAvgArray.last ?? 0, goalValue: 5000.0, units: "", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.db.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        hkm.statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .activeEnergyBurned, units: hkm.activeEnergyQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Activity", value: valuesAvgArray.last ?? 0, goalValue: 300.0, units: "kcal", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.db.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        hkm.statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRateVariabilitySDNN, units: hkm.heartRateVariabilityQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "HRV", value: valuesAvgArray.last ?? 0, goalValue: 12.0, units: "ms", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.db.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        hkm.statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .oxygenSaturation, units: hkm.o2SatQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let lastO2 = (valuesAvgArray.last ?? 0) * 100
            
            let hhData = HHData(id: UUID(), type: "O2 Sat", value: lastO2, goalValue: 0.95,  units: "%",valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.db.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
            
            }
        
        dispatchGroup.notify(queue: .main) {
            let tGoal = Double(self.db.humantiveData.count) * 10
            let hSum = self.db.normalizeHD().0.reduce(0, +)
        let pct = hSum / tGoal
        
        let prehScore = 1000 * pct
            self.hScore = Int(prehScore)
        
        self.showHGraph = true
        
            switch self.hScore {
        
        case 200..<499:
            self.circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .orange, .orange, .green]), startPoint: .top, endPoint: .bottom)
        case 500..<799:
            self.circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .purple, .orange, .green]), startPoint: .top, endPoint: .bottom)
        case 800..<999:
            self.circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .purple, .green, .green]), startPoint: .top, endPoint: .bottom)
        case 1000:
            self.circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .green, .green, .green]), startPoint: .top, endPoint: .bottom)
        default:
            self.circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .orange, .orange, .orange]), startPoint: .top, endPoint: .bottom)
        }
        }
        
    }*/
}
