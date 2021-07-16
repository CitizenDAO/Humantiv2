//
//  LocationManager.swift
//  SiriDemoSwiftUI
//
//  Created by Mark Pruit on 2/5/20.
//  Copyright © 2020 Mark Pruit. All rights reserved.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI


class CoreLocationManager: NSObject, ObservableObject {
    
    static let shared = CoreLocationManager()
    
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var userAltitude: Double = 0
    @Published var speed: Double = 0
    //@Published var placemark: CLPlacemark?
    
    @Published var locality = ""
    @Published var subLocality = ""
    @Published var thoroughfare = ""
    @Published var subthoroughfare = ""
    @Published var postalCode = ""
    @Published var aArea = ""
    @Published var country = ""
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.locationManager.delegate = self
            //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            //self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            //self.locationManager.allowsBackgroundLocationUpdates = true
        }
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.locationManager.startUpdatingLocation()
            }
        }
        print("Unable to get Core Location Information")
    }
    
    func disableLocationMonitoring() {
        DispatchQueue.main.async {
            self.locationManager.stopUpdatingLocation()
        }
    }
}

extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { print("Failed to grab Location")
            return }
        DispatchQueue.main.async {
            self.userLatitude = location.coordinate.latitude
            self.userLongitude = location.coordinate.longitude
            self.userAltitude = location.altitude
            self.speed = location.speed
        }
        //let height = location.floor
        print(location)
        print (location.altitude)
        
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                
                
                if let containsPlacemark = pm {
                    print(containsPlacemark)
                    //stop updating location to save battery life
                    //locationManager.stopUpdatingLocation()
                    let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
                    let subLocality = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality : ""
                    let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
                    let subthoroughfare = (containsPlacemark.subThoroughfare != nil) ? containsPlacemark.subThoroughfare : ""
                    let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
                    let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
                    let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
                    
                    DispatchQueue.main.async {
                        self.locality = locality ?? ""
                        self.postalCode = postalCode ?? ""
                        self.aArea = administrativeArea ?? ""
                        self.country = country ?? ""
                    }
                }
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}

