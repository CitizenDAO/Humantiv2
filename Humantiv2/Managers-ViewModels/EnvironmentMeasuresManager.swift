//
//  EnvironmentMeasuresManager.swift
//  HealthKitMonitoringWorkshop
//
//  Created by Mark Pruit on 2/13/21.
//

import Foundation
import SwiftUI
import Combine

// MARK: POLLENSENSE STUFF***********************************************************************

class EnvironmentalMeasuresManager: ObservableObject {
    
    static let shared = EnvironmentalMeasuresManager()
    //@StateObject var locationManager = CoreLocationManager.shared
    
    @Published var pollensense: PollenSense?
    @Published var deviceId: PSDevice?
    @Published var wb: Weatherbit?
    @Published var wbForecastData: [WBForecast.Data]?
    
    //weatherbit conditions
    @Published var cityName = ""
    @Published var state = ""
    @Published var conditions = ""
    @Published var weatherImage = ""
    @Published var temp = ""
    @Published var pressure = ""
    @Published var rhu = ""
    @Published var wbImage = ""
    
    //weatherbit forecast
    @Published var fWbImage = ""
    @Published var fConditions = ""
    @Published var fTempHi = ""
    @Published var fTempLo = ""
    @Published var fDate = ""
    
 
    private init()
    {

    }
    
    func getNearestPSDevice(lat: Double, long: Double, completion: @escaping (PSDevice) -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard var URL = URL(string: "https://pollenwise.azure-api.net/api/device-closest-provisioned") else {return}
        let URLParams = [
            "key": "8849c8e04cd542feb7f2ce1ebe4586c5",
            "latitude": String(lat),
            "longitude": String(long),
            "code ": "8849c8e04cd542feb7f2ce1ebe4586c5",
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                let data = data!
                let decoder = JSONDecoder()
                
                do {
                    
                    let psDevice = try decoder.decode(PSDevice.self, from: data)
                    
                    
                    completion(psDevice)
                    
                    //print("Nearest Device: \(psDevice.deviceId)")
                    
                } catch let e {
                    print("failed to convert data \(e)")
                }
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    
    func callPollenSense(device: String, completion: @escaping (PollenSense) -> Void) {
   
        //Date Calculations
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = Date()
        let now = dateFormatter.string(from: date)
        print(now)
        //let dayAgo = Date(timeIntervalSinceNow: -86400)
        let dayAgo = Date(timeIntervalSinceNow: -28800)
        let yesterday = dateFormatter.string(from: dayAgo)
        print(yesterday)
        
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard var URL = URL(string: "https://pollenwise.azure-api.net/api/rollup-single/\(device)") else {return}
        let URLParams = [
            //"ending": "2020-02-04T09:00:00.000Z ",
            "ending": now,
            "interval": "hour",
            //"starting": "2020-02-04T06:00:00.000Z ",
            "starting": yesterday,
            "key": "8849c8e04cd542feb7f2ce1ebe4586c5",
            "code": "8849c8e04cd542feb7f2ce1ebe4586c5",
        ]
        
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        // Headers
        
        request.addValue("8849c8e04cd542feb7f2ce1ebe4586c5", forHTTPHeaderField: "x-functions-key")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                let data = data!
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let pollenSense = try decoder.decode(PollenSense.self, from: data)
                    
                    completion(pollenSense)
                    
                } catch let e {
                    print("failed to convert data \(e)")
                }
          
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func callPollenSense2Wk(device: String, date: Date, completion: @escaping (PollenSense) -> Void) {
   
        //Date Calculations
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        //let date = Date()
        let now = dateFormatter.string(from: date)
        print(now)
        //let dayAgo = Date(timeIntervalSinceNow: -86400)
        let dayAgo = Date(timeIntervalSinceNow: -1209600)
        let yesterday = dateFormatter.string(from: dayAgo)
        print(yesterday)
        
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard var URL = URL(string: "https://pollenwise.azure-api.net/api/rollup-single/\(device)") else {return}
        let URLParams = [
            //"ending": "2020-02-04T09:00:00.000Z ",
            "ending": now,
            "interval": "day",
            //"starting": "2020-02-04T06:00:00.000Z ",
            "starting": yesterday,
            "key": "8849c8e04cd542feb7f2ce1ebe4586c5",
            "code": "8849c8e04cd542feb7f2ce1ebe4586c5",
        ]
        
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        // Headers
        
        request.addValue("8849c8e04cd542feb7f2ce1ebe4586c5", forHTTPHeaderField: "x-functions-key")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                let data = data!
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let pollenSense = try decoder.decode(PollenSense.self, from: data)
                    
                    completion(pollenSense)
                    
                } catch let e {
                    print("failed to convert data \(e)")
                }
          
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    // MARK: WEATHER.GOV ****************************
    
    //use gpd coordinates to get the gridId, gridX, and gridY
    func weatherGovGetGrid(lat: Double, long: Double) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //guard var URL = URL(string: "https://api.weather.gov/points/\(lat),\(long)") else
        guard var URL = URL(string: "https://api.weather.gov/points/35.9703,-83.9386") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        // Headers
        request.addValue("mark.pruitt@smokymountainsoftworks.com", forHTTPHeaderField: "User-Agent")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                
                //
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //use the gridId, gridX, gridY in call
    func weatherGovGetForecast(gridId: String, gridX: Int, gridY: Int) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //guard var URL = URL(string: "https://api.weather.gov/gridpoints/\(gridId)/\(gridX),\(gridY)/forecast")
        guard var URL = URL(string: "https://api.weather.gov/gridpoints/MRX/79,52/forecast") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    ////use the gridID, gridX, gridY in call to get the stationIdentifier
    func weatherGovGetStations(gridId: String, gridX: Int, gridY: Int) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // guard var URL = URL(string: "https://api.weather.gov/gridpoints/\(gridId)/\(gridX),\(gridY)/stations")
        guard var URL = URL(string: "https://api.weather.gov/gridpoints/MRX/79,52/stations") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //use the stationIdentifier to get the most recentt station obseervations
    func weatherGovGetObservations(stationId: String) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //guard var URL = URL(string: "https://api.weather.gov//stations/\(stationId)/observations/latest") else {return}
        guard var URL = URL(string: "https://api.weather.gov//stations/KTYS/observations/latest") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    // MARK: WEATHERBIT ****************************
    
    func getConditionsRequest(flareLat: Double, flareLong: Double, completion: @escaping (Weatherbit) -> Void) {
             
             let sessionConfig = URLSessionConfiguration.default
             
             /* Create session, and optionally set a URLSessionDelegate. */
             let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
             
             guard var URL = URL(string: "https://api.weatherbit.io/v2.0/current") else {return}
             
             let URLParams = [
                 "key": "c6c78e49b1de433f8edee039dfd93c1d",
                 //"postal_code": "37921",
                 "lat": flareLat,
                 "lon": flareLong
                 ]  as [String : Any]
             
             URL = URL.appendingQueryParameters(URLParams)
             
             var request = URLRequest(url: URL)
             request.httpMethod = "GET"
             
             /* Start a new Task */
             let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                 if (error == nil) {
                     // Success
                     let statusCode = (response as! HTTPURLResponse).statusCode
                     print("URL Session Task Succeeded: HTTP \(statusCode)")
                     
                     let decoder = JSONDecoder()
                     //let decoded = try decoder.decode(Weatherbit.self, from: data!)
                     
                     guard let json = data else {return}
                     
                     print (json)
                     
                     do {
                         
                         // let dailyBreathResponse = try decoder.decode(DailyBreathResponse.self, from: data!)
                         let weatherBitResponse = try decoder.decode(Weatherbit.self, from: data!)
                         
                         print (weatherBitResponse)
                        
                       DispatchQueue.main.async {
                            self.wb = weatherBitResponse
                       }
                         
                        for dict in weatherBitResponse.data ?? [] {
                            DispatchQueue.main.async {
                                self.cityName = dict.cityName ?? ""
                                self.state = dict.stateCode ?? ""
                                self.conditions = dict.weather?.description ?? ""
                                self.wbImage = dict.weather?.icon ?? ""
                                
                                
                                
                                let farenheit = (dict.temp ?? 0) * 9 / 5 + 32
                                self.temp = String(round(farenheit))
                                self.pressure = String(dict.pres ?? 0.0)
                                self.rhu = String(dict.rh ?? 0.0)
                                
                            }
                        }
                        
                         completion (weatherBitResponse)
                         
                     } catch {
                         print(error.localizedDescription)
                         print (error)
                     }
                 }
                 else {
                     // Failure
                     print("URL Session Task Failed: %@", error!.localizedDescription);
                     DispatchQueue.main.async {
                         
                     }
                 }
             })
             
             task.resume()
             session.finishTasksAndInvalidate()
         }
     
     func getForecast(lat: Double, lon: Double, completion: @escaping (WBForecast) -> Void) {
      
         let sessionConfig = URLSessionConfiguration.default

         /* Create session, and optionally set a URLSessionDelegate. */
         let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

         /* Create the Request:
            Forecast (GET https://api.weatherbit.io/v2.0/forecast/daily)
          */

         guard var URL = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily") else {return}
         let URLParams = [
             "key": "c6c78e49b1de433f8edee039dfd93c1d",
             "lat": lat,
             "lon": lon,
             ] as [String : Any]
         URL = URL.appendingQueryParameters(URLParams)
         var request = URLRequest(url: URL)
         request.httpMethod = "GET"

         /* Start a new Task */
         let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
             if (error == nil) {
                 // Success
                 let statusCode = (response as! HTTPURLResponse).statusCode
                 print("URL Session Task Succeeded: HTTP \(statusCode)")
                 
                 let data = data!
                 let decoder = JSONDecoder()
                               
                     do {
                           let wbForecast = try decoder.decode(WBForecast.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.wbForecastData = wbForecast.data! //{
                            
                            
                            //for dict in wbForecast.data ?? [] {
                                //print(dict.)
                            //}
                       }
                        

                             completion(wbForecast)
                                   
                         } catch let e {
                             print("failed to convert data \(e)")
                         }
                 
             }
             else {
                 // Failure
                 print("URL Session Task Failed: %@", error!.localizedDescription);
             }
         })
         task.resume()
         session.finishTasksAndInvalidate()
     }
    
    func normalizeHealthArray(healthValuesArray: [Double], completion: @escaping ([Double]) -> Void) {
        let sourceArray = healthValuesArray
        guard let min = sourceArray.min() else {return}
        guard let max = sourceArray.max() else {return}
        let results = sourceArray.map { ($0 - min) / (max - min) }
        completion(results)
    }
    
}


//Helpers
protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, Any>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
