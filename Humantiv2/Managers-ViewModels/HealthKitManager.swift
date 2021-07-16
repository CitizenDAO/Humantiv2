//
//  HealthKitManager.swift
//  FirebaseRestKeychainTest
//
//  Created by Mark Pruit on 4/24/20.
//  Copyright © 2020 Mark Pruitt. All rights reserved.
//

import Foundation
import Combine
import HealthKit
import SwiftUI
import UserNotifications

class HealthKitManager: ObservableObject {

    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var weightArray: [Double] = []
    @Published var weightDateArray: [Date] = []
    @Published var weightDate = Date()
    @Published var o2Sat = 0.0
    @Published var o2Date = Date()
    @Published var o2Array: [Double] = []
    @Published var o2DateArray: [Date] = []
    @Published var temperature = 0.0
    @Published var temperatureArray: [Double] = []
    @Published var temperatureDate = Date()
    @Published var temperatureDateArray: [Date] = []
    @Published var bloodGlucose = 0.0
    @Published var bloodGlucoseDate = Date()
    @Published var glucoseArray: [Double] = []
    @Published var glucoseDateArray: [Date] = []
    @Published var insulinDelivery = 0.0
    @Published var insulinDeliveryDate = Date()
    @Published var insulinArray: [Double] = []
    @Published var insulinDateArray: [Date] = []
    @Published var systolicBloodPressure = 0.0
    @Published var systolicArray: [Double] = []
    @Published var systolicDateArray: [Date] = []
    @Published var diastolicBloodPressure = 0.0
    @Published var diastolicArray: [Double] = []
    @Published var diastolicDateArray: [Date] = []
    @Published var bloodPressureDate = Date()
    @Published var fev1 = 0.0
    @Published var fev1Array: [Double] = []
    @Published var fev1DateArray: [Date] = []
    @Published var fvc = 0.0
    @Published var fvcArray: [Double] = []
    @Published var fvcDateArray: [Date] = []
    @Published var soundLevel = 0.0
    @Published var falls = 0.0
    @Published var steps = 0.0
    @Published var stepsDate = Date()
    @Published var walkDistance = 0.0
    @Published var activeEnergy = 0.0
    @Published var standHours = 0.0
    @Published var heartRate = 0
    @Published var stepsArray = [0.0]
    @Published var stepsHrArray = [0.0]
    @Published var hrFinalArray = [0.0]
    @Published var hrHourFinalArray = [0.0]
    @Published var hrDateTImeSteps: [String] = []
    @Published var hrDateTImeHeartRate: [String] = []
    @Published var fev1FinalArray = [0.0]
    //@Published var noiseHRArray: [Double] = []
    //@Published var hrNoiseDateTImeArray: [String] = []
    
    @Published var sleep = 0.0
    @Published var sleepHrv = 0.0
    @Published var lastSleep = 0.0
    @Published var lastSleepHrv = 0.0
    @Published var sleepStartString = ""
    @Published var sleepEndString = ""
    @Published var lastSleepStartString = ""
    @Published var lastSleepEndString = ""
    
    @Published var aSleepTimeStartArray: [Date] = []
    @Published var aSleepTimeEndArray: [Date] = []
    @Published var aSleepTimeStartArrayToday: [Date] = []
    @Published var aSleepTimeEndArrayToday: [Date] = []
    @Published var sleepStartTime = Date()
    @Published var sleepEndTime = Date()
    @Published var sleepStartTimeToday = Date()
    @Published var sleepEndTimeToday = Date()
    
    @Published var mindfulMinutesLast = 0
    @Published var mindfulMinutesTotal = 0
    @Published var dateLastMindfulMinutes = Date()
    @Published var dateLastMindfulMinutesEnded = Date()
    @Published var lastMmHrvString = ""
    
    @Published var mindfulHRV = 0.0
    @Published var dateEndMindfulHRV = Date()
    
    //HRV Arrays
    @Published var hrvValuesArray: [Double] = []
    @Published var mmHrvArray24: [Double] = []
    @Published var mmHRVAvg = 0.0
    @Published var nonMmHrvArray24: [Double] = []
    @Published var hrvStartTimesArray: [Date] = []
    @Published var hrvEndTimesArray: [Date] = []
    @Published var mindfulHrvValuesArray: [Double] = []
    @Published var mindfulHrvEndTimesArray: [Date] = []
    @Published var nonMindfulHrvValuesArray: [Double] = []
    @Published var nonMindfulHrvEndTimesArray: [Date] = []
    
    @Published var sleepHrvMax = 0.0
    @Published var sleepHrvMaxTime = Date()
    @Published var sleepHrvAvg = 0.0
    @Published var lastSleepHrvMax = 0.0
    @Published var lastSleepHrvMaxTime = Date()
    @Published var lastSleepHrvAvg = 0.0
    
    
    @Published var sleepHrvArray: [Double] = []
    @Published var sleepHrvTimesArray: [Date] = []
    @Published var lastSleepHrvArray: [Double] = []
    @Published var lastSleepHrvTimesArray: [Date] = []
    
    @Published var mindfulHrv24Dict: [[Date: Double]] = []
    @Published var nonMindfulHrv24Dict: [[Date: Double]] = []
    
    //Mindfullness Arrays
    @Published var mmValuesArray: [Double] = []
    @Published var mmStartTimesArray: [Date] = []
    @Published var mmEndTimesArray: [Date] = []
    
    @Published var humantiveData: [HHData] = []
    
    @AppStorage("storedLastMmHRV") var storedLastMmHRV: Double = 0.0
    @AppStorage("storedDateLastMmHRVEnded") var storedDateLastMmHRVEnded = Date().timeIntervalSince1970
    
    @Published var healthMeasurables = ["Steps", "Heart Rate", "Activity"]
    
    //Activity chart use
    @Published var sleepHrvLogs: [ActivityLog] = []
    @Published  var sleepHrLogs: [ActivityLog] = []
    @Published  var sleepAeLogs: [ActivityLog] = []
    @Published  var sleepStepLogs: [ActivityLog] = []
    @Published var dailyHrvLogs: [ActivityLog] = []
    
  
    let healthKitStore = HKHealthStore()
    let o2SatQuantity = HKUnit(from: "%")
    let bloodGlucoseQuantity = HKUnit(from: "mg/dL")
    let temperatureQuantity = HKUnit.degreeFahrenheit()
    let insulinDeliveryQuantity = HKUnit.internationalUnit()
    let sysBPQuantity = HKUnit.millimeterOfMercury()
    let diaBPQuantity = HKUnit.millimeterOfMercury()
    let heightQuantity = HKUnit(from: "ft")
    let weightQuantity = HKUnit(from: "lb")
    let fvcQuantity = HKUnit(from: "L")
    let fev1Quantity = HKUnit(from: "L")
    let heartRateQuantity = HKUnit(from: "count/min")
    let activeEnergyQuantity =  HKUnit(from: "kcal")
    let standHoursQuantity =  HKUnit(from: "s")
    let walkingDistanceQuantity =  HKUnit(from: "mi")
    let stepsQuantity =  HKUnit.count()
    let fallsQuantity =  HKUnit.count()
    let envSoundQuantity =  HKUnit(from: "dBASPL")
    let walkDoubleSupportQuantity = HKUnit.percent()
    let walkAssymetryQuantity = HKUnit.percent()
    let walkStepLengthQuantity = HKUnit(from: "in")
    let stairSpeedUpQuantity = HKUnit(from: "ft/s")
    let stairSpeedDownQuantity = HKUnit(from: "ft/s")
    let heartRateVariabilityQuantity = HKUnit(from: "ms")
    
    //clean up the formatter stuff (combinee into 1)
    let formatter1 = DateFormatter()
    let formatter2 = DateFormatter()
    
    let formatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    init() {
        
        //requestPermissions()
        if let measurables = UserDefaults.standard.array(forKey: "healthMeasurables") {
            //print("Favorites exists")
            self.healthMeasurables = measurables as? [String] ?? [String]()

            if measurables.isEmpty {
                print("Favorites is empty")
                let defaults = UserDefaults.standard
                defaults.set(self.healthMeasurables, forKey: "healthMeasurables")
                
            } else {
                print("Favorites is not empty, it has \(measurables.count) items")
            }
        } else {
            print("Favorites is nil")
        }
    }
    
    
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func requestPermissions(){
        //requestNotificationPermissions()

        if !HKHealthStore.isHealthDataAvailable() {
            print("Error: HealthKit is not available in this Device")
            return
        }

        healthKitStore.requestAuthorization(toShare: HealthKitCommons.healthKitTypesToWrite, read: HealthKitCommons.healthKitTypesToRead)
        { (success, error) -> Void in
            print("Read Write Authorization succeeded")
            
            //self.startObservingForHRV()
           
            //self.startHeartRateQuery(quantityTypeIdentifier: .heartRate)
            /*self.getHKValues {
                completion in
                
                print("Done")
            }*/
        }
        
    }
  
// Grab all values over a time interval
    func fetchHKValuesRaw(end: Date, forPast days: Int, identifier: HKQuantityTypeIdentifier, dateComponents: DateComponents, units: HKUnit,  completion: @escaping ([Double], [Date]) -> Void) {
        
        guard let sampleType = HKSampleType.quantityType(forIdentifier: identifier) else {return}
        
        let today = end
        guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: today) else { return}
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery.init(sampleType: sampleType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors: nil) { (query, results, error) in
            
            if let results = results as? [HKQuantitySample]{
                        var valuesArray: [Double] = []
                        var datesArray: [Date] = []
                    
                for result in results {
                        valuesArray.append(result.quantity.doubleValue(for: units))
                        datesArray.append(result.endDate)
                }
               
                    completion(valuesArray, datesArray)
            }else{
                print("OOPS didnt get \(identifier.hashValue) \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        
        healthKitStore.execute(query)
    }
    
//************************ Collection Queries
  
    func statisticsCollectionQuerySumByDateRange(date: Date, interval: DateComponents, dateStart: Date, identifier: HKQuantityTypeIdentifier, units: HKUnit, completion: @escaping ([Double], [Date]) -> Void) {
        
        guard let hrvType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("*** Unable to get the HRV type ***")
        }
        var valuesSumArray: [Double] = []
        var dateSumArray: [Date] = []
        let calendar = Calendar.current
          
          let components = calendar.dateComponents([.year, .month, .day], from: date)
          let startOfMonth = calendar.date(from: components)
          let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startOfMonth!)
        
            print(date)
            print(anchorDate)
        
          
          let query = HKStatisticsCollectionQuery.init(quantityType: hrvType,
                                                       quantitySamplePredicate: nil,
                                                       options: [.cumulativeSum, .separateBySource],
                                                       anchorDate: anchorDate!,
                                                       intervalComponents: interval)
          
          query.initialResultsHandler = {
              query, results, error in
            
            print(dateStart, date)
          
            print("Cumulative Sum")
            results?.enumerateStatistics(from: dateStart,
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.sumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.sumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesSumArray.append(result.sumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateSumArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
              
              print("By Source")
            /*
              for source in (results?.sources())! {
                  print("Next Device: \(source.name)")
                  results?.enumerateStatistics(from: dateStart,
                                               to: date, with: { (result, stop) in
                                                  print("\(result.startDate): \(result.averageQuantity(for: source)?.doubleValue(for: units) ?? 0)lbs")
                  })
              }*/
            
            completion(valuesSumArray, dateSumArray)
          }
          healthKitStore.execute(query)
      }
    
    func statisticsCollectionQueryAvgMaxMinByDateRange(date: Date, interval: DateComponents, dateStart: Date, identifier: HKQuantityTypeIdentifier, units: HKUnit, completion: @escaping ([Double], [Date], [Double], [Date], [Double], [Date]) -> Void) {
        
        guard let hrvType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("*** Unable to get the HRV type ***")
        }
          
        var valuesMaxArray: [Double] = []
        var dateMaxValuesArray: [Date] = []
        var valuesMinArray: [Double] = []
        var dateMinValuesArray: [Date] = []
        var valuesAvgArray: [Double] = []
        var dateAvgArray: [Date] = []
        //var valuesSumArray: [Double] = []
        //var dateSumArray: [Date] = []
        
        //var adjDate = date
        
        let calendar = Calendar.current
          
          let components = calendar.dateComponents([.year, .month, .day], from: date)
          let startOfMonth = calendar.date(from: components)
          let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startOfMonth!)
        
            print(date)
            print(anchorDate)
        
          
          let query = HKStatisticsCollectionQuery.init(quantityType: hrvType,
                                                       quantitySamplePredicate: nil,
                                                       options: [.discreteMin, .discreteMax, .discreteAverage, .separateBySource],
                                                       anchorDate: anchorDate!,
                                                       intervalComponents: interval)
          
          query.initialResultsHandler = {
              query, results, error in
            
            print(dateStart, date)

            print("Discrete Avg")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.averageQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.averageQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesAvgArray.append(result.averageQuantity()?.doubleValue(for: units) ?? 0)
                                                dateAvgArray.append(result.startDate)
                                                
                                                
                                            }
                                            
                                            
            })
            
            print("Discrete Max")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.maximumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.maximumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMaxArray.append(result.maximumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMaxValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
            print("Discrete Min")
            results?.enumerateStatistics(from: dateStart,
                                         to: date, with: { (result, stop) in
                                         //to: Date(), with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.minimumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.minimumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMinArray.append(result.minimumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMinValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
              print("By Source")
            /*
              for source in (results?.sources())! {
                  print("Next Device: \(source.name)")
                  results?.enumerateStatistics(from: dateStart,
                                               to: date, with: { (result, stop) in
                                                  print("\(result.startDate): \(result.averageQuantity(for: source)?.doubleValue(for: units) ?? 0)lbs")
                                                
                                                
                  })
              }*/
            
            completion(valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray)
          }
          healthKitStore.execute(query)
      }
    
    //*********************************** SYMPTOMS GRAB 2/25/2021
    func fetchHKSymptomsReported(end: Date, forPast days: Int, identifier: HKCategoryTypeIdentifier, completion: @escaping (String, Date) -> Void) {
        
        guard let sampleType = HKSampleType.categoryType(forIdentifier: identifier) else {return}
        guard let today = Calendar.current.date(byAdding: .minute, value: 2, to: end) else { return }
        print(today)
        
        guard let startDate = Calendar.current.date(byAdding: .minute, value: -days, to: today) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery.init(sampleType: sampleType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors: nil) { (query, results, error) in
            if let result = results?.last as? HKCategorySample{
                print("\(result.categoryType.identifier) => \(result.description)")
                print(result.metadata ?? [:])
                print(result.startDate)
                print(result.value)
                print(result.categoryType.identifier)
                
            
                if result.value == result.value {
                    let parsed = result.categoryType.identifier.replacingOccurrences(of: "HKCategoryTypeIdentifier", with: "")
                    completion(parsed, result.startDate)                }
            } else {
                print("OOPS didnt get Symptom results \nResults => \(String(describing: results)), error => \(String(describing: error))")
                return
            }
        }
        self.healthKitStore.execute(query)
    }
    
    
    func fetchHKSymptomsReported2wks(end: Date, forPast days: Int, identifier: HKCategoryTypeIdentifier, completion: @escaping (String, Date) -> Void) {
        
        guard let sampleType = HKSampleType.categoryType(forIdentifier: identifier) else {return}
        //let sampleType = identifier
        
        let today = end
        //let today = Calendar.current.date(byAdding: .minute, value: 2, to: end)!
        //guard let today = Calendar.current.date(byAdding: .minute, value: 2, to: end) else { return }
        print(today)
        
        guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: today) else { return }
        //guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: today) else { return }
        //let startDate = Calendar.current.date(byAdding: .minute, value: -days, to: today)
        
        print(startDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery.init(sampleType: sampleType,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors: nil) { (query, results, error) in
            if let result = results?.last as? HKCategorySample{
                print("\(result.categoryType.identifier) => \(result.description)")
                print(result.metadata ?? [:])
                print(result.startDate)
                print(result.value)
                print(result.categoryType.identifier)
                
            
                if result.value == result.value {
                    
                    //if result.value != "" {
                    let parsed = result.categoryType.identifier.replacingOccurrences(of: "HKCategoryTypeIdentifier", with: "")
                    completion(parsed, result.startDate)
                    //}
                }
                
                
                //DispatchQueue.main.async{
                    //self.dyspneaDescription = result.description
                    //self.dyspneaValue = result.value
                    //self.dyspneaDate = result.startDate
                    //self.dyspneaResultDict = [
                       // "description": result.description,
                       // "startDate": result.startDate,
                        //"value": result.value
                   // ]
                //}
                
            } else {
                print("OOPS didnt get Symptom results \nResults => \(String(describing: results)), error => \(String(describing: error))")
                return
            }
        }
        self.healthKitStore.execute(query)
    }
    
    //****************************  Mindful Improved! 3/4/2021
    /*
    func retrieveMindfulValuesOverTimeRange(startDate: Date, endDate: Date, completion: @escaping (Double, Date) -> Void ) {
        var totalMeditationMinutes = 0.0
        print(startDate)
        print(endDate)
        
        let sampleType = HKObjectType.categoryType(forIdentifier: .mindfulSession)!
        
        // Use a sortDescriptor to get the recent data first (optional) and predicate
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        
        // Create the HealthKit Query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: 0,
            sortDescriptors: [sortDescriptor],
            resultsHandler: { (query, results, error) in
                
                print(results)
                
                if error != nil {return}
                
                // Sum the meditation time
                let totalMeditationTime = results?.map(Helpers.calculateTotalTime).reduce(0, { $0 + $1 }) ?? 0
                
                let mostRecentTimeDuration = results?.first?.endDate.timeIntervalSince(results?.first?.startDate ?? Date())
                let lastMm = results?.first?.startDate
                let lastMmEnded = results?.first?.endDate
                
                //last mindful minutes total and date
                var dateLastMindfulMinutesEnded = Date()
                DispatchQueue.main.async {
                    let mindfulMinutesLast = Int(mostRecentTimeDuration ?? 0)
                    self.mindfulMinutesLast = Int(mostRecentTimeDuration ?? 0)
                    
                    let dateLastMindfulMinutes = lastMm ?? Date()
                    self.dateLastMindfulMinutes = lastMm ?? Date()
                    
                    //updatee to last mindful minutes
                    dateLastMindfulMinutesEnded = lastMmEnded ?? Date()
                    self.dateLastMindfulMinutesEnded = lastMmEnded ?? Date()
                }
                
                print("Most recent time spen in meditation: \(String(mostRecentTimeDuration ?? 0.0))")
                print("\n Total: \(totalMeditationTime)")
                
                totalMeditationMinutes = totalMeditationTime / 60
            }
        )
        completion(totalMeditationMinutes, dateLastMindfulMinutesEnded)
        
        // Execute our query
        healthKitStore.execute(query)
    }*/
    
    //************************SLEEP STUFF***********************************************

    // Time Asleep (create a completion handler)
    /*
    func getHealthKitSleep() {
                    let healthStore = HKHealthStore()
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                    // Get all samples from the last 24 hours
                    let endDate = Date()
                    let startDate = endDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
                    // Sleep query
                    let sleepQuery = HKSampleQuery(
                            sampleType: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                            predicate: predicate,
                            limit: 0,
                            sortDescriptors: [sortDescriptor]){ (query, results, error) -> Void in
                                    if error != nil {return}
                                    // Sum the sleep time
                                    var minutesSleepAggr = 0.0
                                    if let result = results {
                                            for item in result {
                                                    if let sample = item as? HKCategorySample {
                                                            if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue && sample.startDate >= startDate {
                                                                    let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                                                                    let minutesInAnHour = 60.0
                                                                    let minutesBetweenDates = sleepTime / minutesInAnHour
                                                                    minutesSleepAggr += minutesBetweenDates
                                                            }
                                                    }
                                            }
                                            self.sleep = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                                            print("HOURS: \(String(describing: self.sleep))")
                                    }
                    }
                    // Execute our query
        self.healthKitStore.execute(sleepQuery)
        }
        */
    func getHealthKitSleep2(startDate: Date, endDate: Date, completion: @escaping ([SleepStruct], [Double]) -> Void ) {
            var ssArray: [SleepStruct] = []
            var sValues: [Double] = []
        
           // var newStartDate = startDate
        
        for i in stride(from: -6, to: 1, by: 1) {
                    //newStartDate = Date().addingTimeInterval(TimeInterval(60*60*24 * (i - 1)))
        
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                    
            var totalSleepTime = 0.0
            
            let predicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(TimeInterval(60*60*24 * (i - 1))), end: Date().addingTimeInterval(TimeInterval(60*60*24 * (i))), options: [])
                    // Sleep query
                    let sleepQuery = HKSampleQuery(
                            sampleType: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                            predicate: predicate,
                            limit: 0,
                            sortDescriptors: [sortDescriptor]){ (query, results, error) -> Void in
                                    if error != nil {return}
                                    // Sum the sleep time
                                    var minutesSleepAggr = 0.0
                                    if let result = results {
                                            for item in result {
                                                    if let sample = item as? HKCategorySample {
                                                        if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue && sample.startDate >= Date().addingTimeInterval(TimeInterval(60*60*24 * (i - 1))) {
                                                            //if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue && sample.startDate >= startDate {
                                                                    let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                                                                    let minutesInAnHour = 60.0
                                                                    let minutesBetweenDates = sleepTime / minutesInAnHour
                                                                    minutesSleepAggr += minutesBetweenDates
                                                            }
                                                    }
                                            }
                                        
                                        totalSleepTime = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                                        
                                        print(totalSleepTime)
                                        
                                        let sStruct = SleepStruct(date: Date().addingTimeInterval(TimeInterval(60*60*24 * (i))), value: totalSleepTime)
                                    
                                        ssArray.append(sStruct)
                                        ssArray = ssArray.sorted { $0.date < $1.date }
                                        sValues = ssArray.map { $0.value }
                                        
                                        print(sStruct)
                                        print (ssArray)
                                        
                                        print(i)
                                        if i == 0 {
                                            completion(ssArray, sValues)
                                        }
                                            //self.sleep = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                                            //print("HOURS: \(String(describing: self.sleep))")
                                    }
                    }
                    // Execute our query
        self.healthKitStore.execute(sleepQuery)
    }
        }
    
    func getLatestHealthKitSleep(date: Date, completion: @escaping (Date, Date, [Date], [Date], Double) -> ()) {
        
        var tempAsleepTimeStartArray: [Date] = []
        var tempAsleepTimeEndArray: [Date] = []
        var tempSleep = 0.0
        var tempSleepStartString = ""
        var tempSleepEndString = ""
        
                    //let healthStore = HKHealthStore()
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                    // Get all samples from the last 24 hours
                    //let endDate = Date()
                    let endDate = date
                    let startDate = endDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
                    // Sleep query
                    let sleepQuery = HKSampleQuery(
                            sampleType: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                            predicate: predicate,
                            limit: 0,
                            sortDescriptors: [sortDescriptor]){ (query, results, error) -> Void in
                                    if error != nil {return}
                                    // Sum the sleep time
                                    var minutesSleepAggr = 0.0
                                    if let result = results {
                                            for item in result {
                                                    if let sample = item as? HKCategorySample {
                                                            if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue && sample.startDate >= startDate {
                                                                    let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                                                                    let minutesInAnHour = 60.0
                                                                    let minutesBetweenDates = sleepTime / minutesInAnHour
                                                                    minutesSleepAggr += minutesBetweenDates
                                                                
                                                                tempAsleepTimeStartArray.append(sample.startDate)
                                                                tempAsleepTimeEndArray.append(sample.endDate)
                                                                
                                                            }
                                                    }
                                            }
                                    }
                        
                        self.formatter1.dateStyle = .medium
                        self.formatter2.timeStyle = .medium
                        
                       
                        tempSleep = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                            print(tempSleep)
                    
                        completion(tempAsleepTimeStartArray.min() ?? Date(), tempAsleepTimeEndArray.max() ?? Date(), tempAsleepTimeStartArray, tempAsleepTimeEndArray, tempSleep )
                    }
        
            self.healthKitStore.execute(sleepQuery)
        }
    
    func getSleepHRV(start: Date, end: Date, completion: @escaping (Double, Double, Date, [Double], [Date]) -> Void) {

                guard let hrvSampleType = HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
                    print("Body Mass Sample Type is no longer available in HealthKit")
                    return
                }

                //1. Use HKQuery to load the most recent samples.
                let mostRecentPredicate = HKQuery.predicateForSamples(withStart: start,
                                                                      end: end,
                                                                      options: [])
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                      ascending: false)
                let limit = 10
                let sampleQuery = HKSampleQuery(sampleType: hrvSampleType,
                                                predicate: mostRecentPredicate,
                                                limit: limit,
                                                sortDescriptors: [sortDescriptor]) { (query, samples, error) in


                    guard let samples = samples as? [HKQuantitySample] else { return }
                                                            
                    
                    
                    var tempHrvArray: [Double] = []
                    var tempHrvTimeArray: [Date] = []
                    
                    for sample in samples {
                        let value = sample.quantity.doubleValue(for: HKUnit(from: "ms"))
                        tempHrvArray.append(value)
                        tempHrvTimeArray.append(sample.endDate)
                    }
                    
                    print(tempHrvArray)
                    print(tempHrvTimeArray)
                    
                    var tempHrvAvg = 0.0
                    var tempMaxHrvTime = Date()
                    
                    if tempHrvArray.count > 0 {
                        let sumArray = tempHrvArray.reduce(0, +)
                        let avgArrayValue = sumArray / Double(tempHrvArray.count)
                        tempHrvAvg = avgArrayValue
                        
                        //Get Max Sleep HRV Time
                        let max = tempHrvArray.max() ?? 0.0
                        let times_and_values = zip(tempHrvTimeArray, tempHrvArray)
                        for time in times_and_values{
                            if time.1 == max {
                                //sleep HRVMax time
                                tempMaxHrvTime = time.0
                                
                            }
                        }
                    }
                    
                    completion(tempHrvAvg, tempHrvArray.max() ?? 0.0, tempMaxHrvTime, tempHrvArray, tempHrvTimeArray)
                    
                    DispatchQueue.main.async {
                        self.lastSleepHrvAvg = tempHrvAvg
                        self.lastSleepHrvMax = tempHrvArray.max() ?? 0.0
                        self.lastSleepHrvMaxTime = tempMaxHrvTime
                        self.lastSleepHrvArray = tempHrvArray
                        self.lastSleepHrvTimesArray = tempHrvTimeArray
                    }
                    print("Last Sleep HRV Avg:\(tempHrvAvg)")
                    print(tempHrvArray)
                    print(tempHrvTimeArray)
                                                 
                }
        
        self.healthKitStore.execute(sampleQuery)
        }
    
    func retrieveMindfulValuesOverTimeRange3(startDate: Date, endDate: Date, completion: @escaping ([MindfulStruct], [Double]) -> Void ) {
        //RIght now the startDate and endDate parameters are not used
        var mmArray: [MindfulStruct] = []
        var mValues: [Double] = []
        
        for i in stride(from: -6, to: 1, by: 1) {
            //startDate: Date().addingTimeInterval(TimeInterval(60*60*24 * (i - 1))), endDate: Date().addingTimeInterval(TimeInterval(60*60*24 * (i))))
        //}
        
        var totalMeditationMinutes = 0.0
        let sampleType = HKObjectType.categoryType(forIdentifier: .mindfulSession)!
        
        // Use a sortDescriptor to get the recent data first (optional) and predicate
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        //let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        let predicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(TimeInterval(60*60*24 * (i - 1))), end: Date().addingTimeInterval(TimeInterval(60*60*24 * (i))), options: [])
            //let predicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(TimeInterval(60*60*24 * (-1))), end: Date(), options: [])
        
        // Create the HealthKit Query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: 0,
            sortDescriptors: [sortDescriptor],
            resultsHandler: { (query, results, error) in
                
                print(results)
                
                if error != nil {return}
                
                // Sum the meditation time
                let totalMeditationTime = results?.map(self.calculateTotalTime).reduce(0, { $0 + $1 }) ?? 0
           
                print("\n Total: \(totalMeditationTime)")
                
                totalMeditationMinutes = totalMeditationTime / 60
                
                let mStruct = MindfulStruct(date: Date().addingTimeInterval(TimeInterval(60*60*24 * (i))), value: totalMeditationMinutes)
            
                mmArray.append(mStruct)
                mmArray = mmArray.sorted { $0.date < $1.date }
                mValues = mmArray.map { $0.value }
                
                print(mStruct)
                print (mmArray)
                
                print(i)
                if i == 0 {
                    completion(mmArray, mValues)
                }
                
            }
        )

            healthKitStore.execute(query)
        }
        
    }
    
    func calculateTotalTime(sample: HKSample) -> TimeInterval {
        let totalTime = sample.endDate.timeIntervalSince(sample.startDate)
        let wasUserEntered = sample.metadata?[HKMetadataKeyWasUserEntered] as? Bool ?? false
        
        print("\nHealthkit mindful entry: \(sample.startDate) \(sample.endDate) - value: \(totalTime) quantity: \(totalTime) user entered: \(wasUserEntered)\n")
        
        return totalTime
    }
    
    //Added back for sleep analysis
    func statisticsCollectionQueryDiscreteBetweenDates(date: Date, interval: DateComponents, dateStart: Date, identifier: HKQuantityTypeIdentifier, units: HKUnit, completion: @escaping ([Double], [Date]) -> Void) {
        
        guard let hrvType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("*** Unable to get the HRV type ***")
        }
          
        //var valuesMaxArray: [Double] = []
        //var dateMaxValuesArray: [Date] = []
        //var valuesMinArray: [Double] = []
        //var dateMinValuesArray: [Date] = []
        //var valuesAvgArray: [Double] = []
        //var dateAvgArray: [Date] = []
        var valuesSumArray: [Double] = []
        var dateSumArray: [Date] = []
        
        //var adjDate = date
        
        let calendar = Calendar.current
          
          let components = calendar.dateComponents([.year, .month, .day], from: date)
          let startOfMonth = calendar.date(from: components)
          let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startOfMonth!)
        
            print(date)
            print(anchorDate)
        
          
          let query = HKStatisticsCollectionQuery.init(quantityType: hrvType,
                                                       quantitySamplePredicate: nil,
                                                       options: [.cumulativeSum, .separateBySource],
                                                       anchorDate: anchorDate!,
                                                       intervalComponents: interval)
          
          query.initialResultsHandler = {
              query, results, error in
            
            print(dateStart, date)
            
            /*
            print("Discrete Avg")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.averageQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.averageQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesAvgArray.append(result.averageQuantity()?.doubleValue(for: units) ?? 0)
                                                dateAvgArray.append(result.startDate)
                                                
                                                
                                            }
                                            
                                            
            })
            
            print("Discrete Max")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.maximumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.maximumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMaxArray.append(result.maximumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMaxValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
            print("Discrete Min")
            results?.enumerateStatistics(from: dateStart,
                                         to: date, with: { (result, stop) in
                                         //to: Date(), with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.minimumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.minimumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMinArray.append(result.minimumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMinValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })*/
            
            print("Cumulative Sum")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.sumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.sumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesSumArray.append(result.sumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateSumArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
              
              print("By Source")
              for source in (results?.sources())! {
                  print("Next Device: \(source.name)")
                  results?.enumerateStatistics(from: dateStart,
                                               to: date, with: { (result, stop) in
                                                  print("\(result.startDate): \(result.averageQuantity(for: source)?.doubleValue(for: units) ?? 0)lbs")
                                                
                                                
                  })
              }
            
            completion(valuesSumArray, dateSumArray)
          }
          healthKitStore.execute(query)
      }
    
    func statisticsCollectionQueryDiscreteBetweenNoSum(date: Date, interval: DateComponents, dateStart: Date, identifier: HKQuantityTypeIdentifier, units: HKUnit, completion: @escaping ([Double], [Date], [Double], [Date], [Double], [Date]) -> Void) {
        
        guard let hrvType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("*** Unable to get the HRV type ***")
        }
          
        var valuesMaxArray: [Double] = []
        var dateMaxValuesArray: [Date] = []
        var valuesMinArray: [Double] = []
        var dateMinValuesArray: [Date] = []
        var valuesAvgArray: [Double] = []
        var dateAvgArray: [Date] = []
        //var valuesSumArray: [Double] = []
        //var dateSumArray: [Date] = []
        
        //var adjDate = date
        
        let calendar = Calendar.current
          
          let components = calendar.dateComponents([.year, .month, .day], from: date)
          let startOfMonth = calendar.date(from: components)
          let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startOfMonth!)
        
            print(date)
            print(anchorDate)
        
          
          let query = HKStatisticsCollectionQuery.init(quantityType: hrvType,
                                                       quantitySamplePredicate: nil,
                                                       options: [.discreteMin, .discreteMax, .discreteAverage, .separateBySource],
                                                       anchorDate: anchorDate!,
                                                       intervalComponents: interval)
          
          query.initialResultsHandler = {
              query, results, error in
            
            print(dateStart, date)

            print("Discrete Avg")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.averageQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.averageQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesAvgArray.append(result.averageQuantity()?.doubleValue(for: units) ?? 0)
                                                dateAvgArray.append(result.startDate)
                                                
                                                
                                            }
                                            
                                            
            })
            
            print("Discrete Max")
            results?.enumerateStatistics(from: dateStart,
                                         //to: Date(), with: { (result, stop) in
                                         to: date, with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.maximumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.maximumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMaxArray.append(result.maximumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMaxValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
            print("Discrete Min")
            results?.enumerateStatistics(from: dateStart,
                                         to: date, with: { (result, stop) in
                                         //to: Date(), with: { (result, stop) in
                                            print("Day: \(result.startDate), \(result.minimumQuantity()?.doubleValue(for: units) ?? 0)ms")
                                            
                                            if (result.minimumQuantity()?.doubleValue(for: units) ?? 0) > 0 {
                                                valuesMinArray.append(result.minimumQuantity()?.doubleValue(for: units) ?? 0)
                                                dateMinValuesArray.append(result.startDate)
                                            }
                                            
                                            
            })
            
              print("By Source")
              for source in (results?.sources())! {
                  print("Next Device: \(source.name)")
                  results?.enumerateStatistics(from: dateStart,
                                               to: date, with: { (result, stop) in
                                                  print("\(result.startDate): \(result.averageQuantity(for: source)?.doubleValue(for: units) ?? 0)lbs")
                                                
                                                
                  })
              }
            
            completion(valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray)
          }
          healthKitStore.execute(query)
      }
    
    //********************Save to HEALTHKIT********************************************
    //Save Symptom
    func saveSymptom(date: Date, severity: Int, hkIdentifier: HKCategoryTypeIdentifier) {
        let charType = HKObjectType.categoryType(forIdentifier: hkIdentifier)!
        let dyspneaEval = HKCategorySample.init(type: charType, value: severity, start: date, end: date)
        healthKitStore.save(dyspneaEval) { success, error in
            if (error != nil) {
                print("Error: \(String(describing: error))")
            }
            if success {
                print("Saved: \(success)")
            }
        }
    }
    
    //Save General single entity
    func saveSingleMeasureToHk (hkType: HKQuantityType ,hkValue: Double, hkUnit: HKUnit, meta: [String: Any]? = nil) {
        // Type of sample
        let unit = hkUnit
        // Date of sample
        let start = Date()
        let end = start
        //Set up Quantity Type
        let sampleQuantity = HKQuantity(unit: unit, doubleValue: hkValue)
        let sampleType = hkType
        let sample   = HKQuantitySample(
            type: sampleType,
            quantity: sampleQuantity,
            start: start,
            end: end,
            metadata: meta
        )
        //Save the measure to HealthKit
        healthKitStore.save(sample) { success, error in
            
            print("Saved \(sample)")
        }
    }
    
    //Save BP
    func saveBptoHk(systolic: Double, diastolic: Double) {
        // Type of sample
        let unit = HKUnit.millimeterOfMercury()
        // Date of sample
        let start = Date()
        let end = start
        //Systolic
        let sQuantity = HKQuantity(unit: unit, doubleValue: systolic)
        let sType = HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)!
        let sSample = HKQuantitySample(
            type: sType,
            quantity: sQuantity,
            start: start,
            end: end
        )
        //Diastolic
        let dQuantity = HKQuantity(unit: unit, doubleValue: diastolic)
        let dType = HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        let dSample = HKQuantitySample(
            type: dType,
            quantity: dQuantity,
            start: start,
            end: end
        )
        //Bind and create correlation
        let objects: Set<HKSample> = [ sSample, dSample ]
        let bpType = HKCorrelationType.correlationType(forIdentifier: .bloodPressure)!

        let bloodPressure = HKCorrelation(
            type: bpType,
            start: start,
            end: end,
            objects: objects
        )
        //Save the corrlation to HealthKit
        healthKitStore.save(bloodPressure) { success, error in
            
            print("Saved Blood Pressure!")
        }
    }
    
    //improve this
    func saveMeditation(startDate:Date, minutes: Int) {
            let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
            let mindfulSample = HKCategorySample(type: mindfulType!, value: 0, start: Date.init(timeIntervalSinceNow: -(15*60)), end: Date())
            healthKitStore.save(mindfulSample) { success, error in
                if(error != nil) {
                    abort()
                }
            }
        }
    
//******* TEMPORARILY KILLING BACKGROUND OBBSERVER NOTIFICATION STUFF
    
    //*******************************OBSERVER QUERY STUFF**************************************
    
    func startObservingForHRV() {

        //let sampleType =  HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        guard let sampleType =  HKObjectType.categoryType(forIdentifier: .mindfulSession) else { return }

        //1. Enable background delivery for heeartratevariability
        self.healthKitStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { (success, error) in
            if let unwrappedError = error {
                print("could not enable background delivery: \(unwrappedError)")
            }
            if success {
                print("background delivery enabled")
            }
        }

        //2.  open observer query
        let observerQuery = HKObserverQuery(sampleType: sampleType, predicate: nil) { (query, completionHandler, error) in
            DispatchQueue.main.async{
                self.updateFEV1FromBackground() {
                completionHandler()
            }
            }
        }
        healthKitStore.execute(observerQuery)

    }

    func updateFEV1FromBackground(completionHandler: @escaping () -> Void) {
        //let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        var anchor: HKQueryAnchor?

        let sampleType =  HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!

        let anchoredQuery = HKAnchoredObjectQuery(type: sampleType, predicate: nil, anchor: anchor, limit: HKObjectQueryNoLimit) { [unowned self] query, newSamples, deletedSamples, newAnchor, error in
            DispatchQueue.main.async{
                self.handleFEV1FromBackground(new: newSamples!, deleted: deletedSamples!)
            }
            anchor = newAnchor

            completionHandler()
        }
        healthKitStore.execute(anchoredQuery)


    }

    func handleFEV1FromBackground(new: [HKSample], deleted: [HKDeletedObject]) {
        //Just to test its working initially
        print("new sample added = \(new.last?.startDate)")
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        
        //Can link to FEV1 Quatity Query here and then write data to server...
        guard let new = new as? [HKQuantitySample] else { return }
        for newSample in new {
            print(newSample.startDate)
            print(newSample.endDate)
            print(newSample.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli)))
            //print(newSample.quantity.doubleValue(for: self.)
        }
        
//******* TEMPORARILY KILLING BACKGROUND OBBSERVER NOTIFICATION STUFF
 /*
        //Add Notification as example (if you do this be sure and import UserNotifications)
        let content = UNMutableNotificationContent()
        let hrvValue = new.last?.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli)) ?? 0.0
                                                       
        content.title = "💙 New HR Variabilitty Data"
        content.subtitle = "HR Variability \(String(hrvValue)) ms"
        content.sound = UNNotificationSound.default

        // show this notification one second from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
*/
        
        
    }

    //*********NEW SYMPTOMS TYPE********************************
 
    //*****************READ SYMPTOM DATA**************************
    func grabCoughData() {
        guard let coughType = HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.coughing)else{return}
        let coughQuery = HKSampleQuery(sampleType: coughType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (coughQuery, results, error) in
            if let result = results?.last as? HKCategorySample{
                print("Cough => \(result.description)")
                print(result.metadata ?? [:])
                print(result.startDate)
                print(result.value)
                
                DispatchQueue.main.async{
                    //self.coughDescription = result.description
                }
            }else{
                print("OOPS didnt get Cough results \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        self.healthKitStore.execute(coughQuery)
    }
    
    func grabDyspneaData() {
        guard let dyspneaType = HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.shortnessOfBreath)else{return}
        let dyspneaQuery = HKSampleQuery(sampleType: dyspneaType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (dyspneaQuery, results, error) in
            if let result = results?.last as? HKCategorySample{
                print("Dyspnea => \(result.description)")
                print(result.metadata ?? [:])
                print(result.startDate)
                print(result.value)
                
                DispatchQueue.main.async{
                    //self.dyspneaDescription = result.description
                    //self.dyspneaValue = result.value
                    //self.dyspneaDate = result.startDate
                    //self.dyspneaResultDict = [
                       // "description": result.description,
                       // "startDate": result.startDate,
                        //"value": result.value
                   // ]
                }
            }else{
                print("OOPS didnt get Dyspnea results \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        self.healthKitStore.execute(dyspneaQuery)
    }
    
    func startItUp(completion: @escaping (Bool) -> Void) {
        requestPermissions()
        
        healthMeasurables.removeDuplicates()
        
        formatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
        
        var interval = DateComponents()
        interval.day = 1
        
        let startDate = Date().addingTimeInterval(86400 * 7 * -1)

        print(startDate)
        
        humantiveData = []

        let dispatchGroup = DispatchGroup()
        
        if healthMeasurables.contains("Weight") {
            
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .bodyMass, units: weightQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Weight", value: valuesAvgArray.last ?? 0, goalValue: 200.0, units: "lbs", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
    }
        
        if healthMeasurables.contains("Heart Rate") {
            
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRate, units: heartRateQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Heart Rate", value: valuesAvgArray.last ?? 0, goalValue: 85.0, units: "bpm", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
    }
        
        if healthMeasurables.contains("Steps") {
        dispatchGroup.enter()
        statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .stepCount, units: stepsQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Steps", value: valuesAvgArray.last ?? 0, goalValue: 5000.0, units: "", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        }
        
        if healthMeasurables.contains("Activity") {
        
        dispatchGroup.enter()
        statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .activeEnergyBurned, units: activeEnergyQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Activity", value: valuesAvgArray.last ?? 0, goalValue: 300.0, units: "kcal", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        }
        
        if healthMeasurables.contains("Heart Rate Variability") {
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRateVariabilitySDNN, units: heartRateVariabilityQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "HRV", value: valuesAvgArray.last ?? 0, goalValue: 12.0, units: "ms", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        }
        
        if healthMeasurables.contains("O2 Saturation") {
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .oxygenSaturation, units: o2SatQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let lastO2 = (valuesAvgArray.last ?? 0) * 100
            
            let hhData = HHData(id: UUID(), type: "O2 Sat", value: lastO2, goalValue: 0.95,  units: "%",valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
            
            }
        }
        
        if healthMeasurables.contains("Blood Pressure") {
        dispatchGroup.enter()
        // grab systolic
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .bloodPressureSystolic, units: sysBPQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "SysBP", value: valuesAvgArray.last ?? 0, goalValue: 0.95,  units: "%",valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
                }

            }
            
            self.statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .bloodPressureDiastolic, units: self.diaBPQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
                
                print(valuesAvgArray)
                print(dateAvgArray)
                
                let hhData = HHData(id: UUID(), type: "DiaBP", value: valuesAvgArray.last ?? 0, goalValue: 0.95,  units: "%",valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
                DispatchQueue.main.async {
                    self.humantiveData.append(hhData)
                }
                
            dispatchGroup.leave()
        }
        }
        
        //Mindful minutes
        if healthMeasurables.contains("Mindfulness") {
        dispatchGroup.enter()
        retrieveMindfulValuesOverTimeRange3(startDate: Date().addingTimeInterval(TimeInterval(60*60*24 * (-1))), endDate: Date()) { mmStruct, mmValues in
            
        let hhData = HHData(id: UUID(), type: "Mindfulness", value: mmStruct.last?.value ?? 0, goalValue: 2,  units: "min", valueArray: mmValues, obsTime: mmStruct.last?.date ?? Date())
  
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
                //dispatchGroup.leave()
            }

        dispatchGroup.leave()
                }
        }
        
        //Sleep
        if healthMeasurables.contains("Sleep") {
        dispatchGroup.enter()
            getHealthKitSleep2(startDate: Date().addingTimeInterval(TimeInterval(60*60*24 * (-1))), endDate: Date()) { mmStruct, mmValues in
            
        let hhData = HHData(id: UUID(), type: "Sleep", value: mmStruct.last?.value ?? 0, goalValue: 2,  units: "hrs", valueArray: mmValues, obsTime: mmStruct.last?.date ?? Date())
  
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
                //dispatchGroup.leave()
            }

        dispatchGroup.leave()
                }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
    }
    
    func startItUp2(completion: @escaping (Bool) -> Void) {
        requestPermissions()
        
        formatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
        
        var interval = DateComponents()
        interval.day = 1
        
        let startDate = Date().addingTimeInterval(86400 * 7 * -1)

        print(startDate)
        
        humantiveData = []

        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRate, units: heartRateQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Heart Rate", value: valuesAvgArray.last ?? 0, goalValue: 85.0, units: "bpm", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .stepCount, units: stepsQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Steps", value: valuesAvgArray.last ?? 0, goalValue: 5000.0, units: "", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        statisticsCollectionQuerySumByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .activeEnergyBurned, units: activeEnergyQuantity) { valuesAvgArray, dateAvgArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "Activity", value: valuesAvgArray.last ?? 0, goalValue: 300.0, units: "kcal", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .heartRateVariabilitySDNN, units: heartRateVariabilityQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let hhData = HHData(id: UUID(), type: "HRV", value: valuesAvgArray.last ?? 0, goalValue: 12.0, units: "ms", valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        statisticsCollectionQueryAvgMaxMinByDateRange(date: Date(), interval: interval, dateStart: startDate, identifier: .oxygenSaturation, units: o2SatQuantity) { valuesAvgArray, dateAvgArray, valuesMaxArray, dateMaxValuesArray, valuesMinArray, dateMinValuesArray in
            
            print(valuesAvgArray)
            print(dateAvgArray)
            
            let lastO2 = (valuesAvgArray.last ?? 0) * 100
            
            let hhData = HHData(id: UUID(), type: "O2 Sat", value: lastO2, goalValue: 0.95,  units: "%",valueArray: valuesAvgArray, obsTime: dateAvgArray.last ?? Date())
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
            }
            dispatchGroup.leave()
            
            }
        
        //Mindful minutes
        dispatchGroup.enter()
        retrieveMindfulValuesOverTimeRange3(startDate: Date().addingTimeInterval(TimeInterval(60*60*24 * (-1))), endDate: Date()) { mmStruct, mmValues in
            
            //print(mmStruct, mmValues)
                  
        let hhData = HHData(id: UUID(), type: "Mindfulness", value: mmStruct.last?.value ?? 0, goalValue: 2,  units: "min", valueArray: mmValues, obsTime: mmStruct.last?.date ?? Date())
  
            DispatchQueue.main.async {
                self.humantiveData.append(hhData)
                
            }

        dispatchGroup.leave()
                }

        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
        
    }
    
}
