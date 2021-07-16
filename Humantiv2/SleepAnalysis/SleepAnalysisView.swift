//
//  SleepAnalysisView.swift
//  Humantiv2
//
//  Created by Mark Pruit on 7/12/21.
//

import SwiftUI
import HealthKit

struct SleepAnalysisView: View {
    @ObservedObject var hkModel: HealthKitManager
    @State var sleepHrvLogs: [ActivityLog] = []
    @State var sleepHrLogs: [ActivityLog] = []
    @State var sleepAeLogs: [ActivityLog] = []
    @State var sleepStepLogs: [ActivityLog] = []
    @State var sleepHrValuesArray: [Double] = []
    @State var sleepHrTimesArray: [Date] = []
    @State var sleepActEValuesArray: [Double] = []
    @State var sleepActETimesArray: [Date] = []
    @State var sleepStepsValuesArray: [Double] = []
    @State var sleepStepsTimesArray: [Date] = []
    
    @State var showingStatusView = false
    @State var dailyHrvLogs: [ActivityLog] = []
    
    let formatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    func startSleepAnalysis() {
        formatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
        
        var interval = DateComponents()
        interval.hour = 1
        
        hkModel.getLatestHealthKitSleep(date: Date()) {
            start, end, stArray, etArray, sleepAmt in
            
            self.hkModel.getSleepHRV(start: start, end: end) {
                avg, max, maxtime, values, times in
                
                //Get HR, Activitty, and Steps data when asleep
                self.hkModel.statisticsCollectionQueryDiscreteBetweenNoSum(date: end, interval: interval, dateStart: start, identifier: .heartRate, units: HKUnit(from: "count/min")) {
                    valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
                    
                    var actLogs:[ActivityLog] = []
                    //var aeLogs:[ActiveEnergyLog] = []
                    //var stepLogs:[StepsLog] = []
                    
                    let sequence = zip(valuesAvgArray, dateAvgArray)
                    
                    for (el1, el2) in sequence {
                        print("\(el1) - \(el2)")
                        
                        let itemLog = ActivityLog(value: el1, date: el2, lg: [.red, .red])
                        actLogs.append(itemLog)
                    }
                    
                    DispatchQueue.main.async {
                        self.sleepHrValuesArray = valuesAvgArray
                        self.sleepHrTimesArray = dateAvgArray
                        //self.sleepHrLogs = actLogs
                        self.hkModel.sleepHrLogs = actLogs
                    }
                }
                
                
                //temp date array
                var tempActArr: [Date] = []
                
                self.hkModel.statisticsCollectionQueryDiscreteBetweenDates(date: end, interval: interval, dateStart: start, identifier: .activeEnergyBurned, units: HKUnit(from: "Cal")) {
                    valuesSumArray, dateSumArray in
                    
                    //var hrLogs:[HeartRateLog] = []
                    var actLogs:[ActivityLog] = []
                    //var stepLogs:[StepsLog] = []
                    
                    let sequence = zip(valuesSumArray, dateSumArray)
                    
                    for (el1, el2) in sequence {
                        print("\(el1) - \(el2)")
                        
                        let itemLog = ActivityLog(value: el1, date: el2, lg: [.blue, .blue, .white])
                        actLogs.append(itemLog)
                    }
                    
                    //a ttemporay act log array
                    // tempActLog = actLogs.sorted(by: {
                    //    $0.date.compare($1.date) == .orderedDescending
                    // })
                    
                    DispatchQueue.main.async {
                        self.sleepActEValuesArray = valuesSumArray
                        self.sleepActETimesArray = dateSumArray
                        //self.sleepAeLogs = actLogs
                        self.hkModel.sleepAeLogs = actLogs
                    }
                    
                    tempActArr = dateSumArray
                }
                
                
                //for name in names where name.hasPrefix("Michael") {
                //print(name)
                //}
                
                
                self.hkModel.statisticsCollectionQueryDiscreteBetweenDates(date: end, interval: interval, dateStart: start, identifier: .stepCount, units: HKUnit.count()) {
                    valuesSumArray, dateSumArray in
                    
                    var actLogs:[ActivityLog] = []
                    
                    let sequence = zip(valuesSumArray, dateSumArray)
                    
                    
                    //Get the unaccountted times
                    //let diffArr = tempActArr.difference(from:dateSumArray)
                    let diffArr = Set(tempActArr).symmetricDifference(dateSumArray)
                    
                    for (el1, el2) in sequence {
                        print("\(el1) - \(el2)")
                        let itemLog = ActivityLog(value: el1, date: el2, lg: [.white, .yellow, .orange, .orange])
                        actLogs.append(itemLog)
                    }
                    
                    if diffArr.count > 0 {
                        for actDate in diffArr {
                            let mSteps = ActivityLog(value: 0.0, date: actDate, lg: [.white, .yellow, .orange, .orange])
                            actLogs.append(mSteps)
                        }
                    }
                    
                    var hrvLogs:[ActivityLog] = []
                    
                    //Sleep time range
                    let timeRange = start...end
                    print(timeRange)
                    
                    print(tempActArr)
                    print(diffArr)
                    print(actLogs.sorted(by: {$0.date.compare($1.date) == .orderedAscending }))
                    
                    DispatchQueue.main.async {
                        self.sleepStepsValuesArray = valuesSumArray
                        self.sleepStepsTimesArray = dateSumArray
                        self.hkModel.sleepStepLogs = actLogs.sorted(by: {$0.date.compare($1.date) == .orderedAscending })
                        
                        
                        //self.hrvValuesArray = valuesArray
                        //self.hrvStartTimesArray = starts
                        let sequence2 = zip(hkModel.hrvValuesArray.reversed(), hkModel.hrvEndTimesArray.reversed())
                        
                        for (el1a, el2a) in sequence2 {
                            print("\(el1a) - \(el2a)")
                            
                            //Color the time asleep different
                            //let timeRange = hkModel.sleepStartTime...hkModel.sleepEndTime
                            if timeRange.contains(el2a) {
                                let itemLog = ActivityLog(value: el1a, date: el2a, lg: [.pink, .pink, .purple, .gray, .white])
                                hrvLogs.append(itemLog)
                                print(el2a)
                                
                            } else {
                                let itemLog = ActivityLog(value: el1a, date: el2a, lg: [.pink, .pink, .purple, .gray, .white])
                                hrvLogs.append(itemLog)
                            }
                            //self.dailyHrvLogs = hrvLogs
                            self.hkModel.dailyHrvLogs = hrvLogs
                        }
                        
                        
                    }
                }
                
                
                
                DispatchQueue.main.async {
                    //sleep info
                    self.hkModel.lastSleep = sleepAmt
                    self.hkModel.lastSleepStartString = ("Fell Asleep: \(self.formatter.string(from: (start)))   \(self.timeFormatter.string(from: (start)))")
                    self.hkModel.lastSleepEndString = ("Woke Up: \(self.formatter.string(from: (end)))   \(self.timeFormatter.string(from: (end)))")
                    
                    self.hkModel.sleepStartTime = start
                    self.hkModel.sleepEndTime = end
                    
                    //sleep hrv info
                    self.hkModel.lastSleepHrvMax = max
                    self.hkModel.lastSleepHrvMaxTime = maxtime
                    self.hkModel.lastSleepHrvAvg = avg
                    self.hkModel.lastSleepHrvArray = values
                    self.hkModel.lastSleepHrvTimesArray = times
                }
            }
        }
    }
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Label("Sleep Analysis", systemImage: "sleep")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                    
                    Spacer()
                }
                if hkModel.lastSleep > 1 {
                    HStack {
                        VStack {
                            HStack {
                                Text ("Sleep Max HRV: \(hkModel.lastSleepHrvMax)")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Text("Last Avg Sleep HRV \(hkModel.lastSleepHrvAvg)")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Text (String(hkModel.lastSleepStartString))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Text (String(hkModel.lastSleepEndString))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Text ("Hours of sleep:\(String(hkModel.lastSleep))")
                                    //.padding(.bottom,7)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }.padding(.leading)
                        .font(.system(size: 18.0))
                        Spacer()
                    }
                    
                    ActivityHistoryView(hkModel: hkModel)
                        .padding(.bottom)
                    
                } else {
                    VStack {
                        Text("Sleep Data Not Available")
                            .bold()
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }.border(Color.white, width: 2)
                    .shadow(radius: 5)
                    .padding(.bottom)
                }
            }
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .black, .black, .black, .black, .black]), startPoint: .bottomLeading, endPoint: .topTrailing))
        .cornerRadius(10)
        .shadow(radius: 10)
        .onAppear(perform: startSleepAnalysis)
    }
}

struct SleepAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        SleepAnalysisView(hkModel: HealthKitManager())
    }
}
