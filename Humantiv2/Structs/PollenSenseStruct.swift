//
//  PollenSenseStruct.swift
//  SiriDemoSwiftUI
//
//  Created by Mark Pruit on 2/4/20.
//  Copyright © 2020 Mark Pruit. All rights reserved.
//

import Foundation

public struct PollenSense: Codable, Hashable {
    
    /*
    public func hash(into hasher: inout Hasher) {
        hasher.combine(starting)
    }
    public static func == (lhs: PollenSense, rhs: PollenSense) -> Bool {
        return lhs.starting == rhs.starting
    }*/
 
    public let starting: String?
    public let ending: String?
    public let interval: String?
    public let moments: [String]?
    public struct Categorie: Codable, Hashable {
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(categoryCode)
        }
        public static func == (lhs: Categorie, rhs: Categorie) -> Bool {
            return lhs.categoryCode == rhs.categoryCode
        }
        
        
        public let categoryCode: String?
        public let categoryDescription: String?
        public let categoryCommonName: String?
        public let categoryGroupCode: String?
        public let deviceId: Int?
        public let pPM3: [Double]?
        public let misery: [Double]?
        private enum CodingKeys: String, CodingKey {
            case categoryCode = "CategoryCode"
            case categoryDescription = "CategoryDescription"
            case categoryCommonName = "CategoryCommonName"
            case categoryGroupCode = "CategoryGroupCode"
            case deviceId = "DeviceId"
            case pPM3 = "PPM3"
            case misery = "Misery"
        }
    }
    public let categories: [Categorie]?
    public let conditions: [String]? //TODO: Specify the type to conforms Codable protocol
    private enum CodingKeys: String, CodingKey {
        case starting = "Starting"
        case ending = "Ending"
        case interval = "Interval"
        case moments = "Moments"
        case categories = "Categories"
        case conditions = "Conditions"
    }
}

public struct PSDevice: Codable {
    public let deviceId: Int?
    public let latitude: Double?
    public let longitude: Double?
    public let altitude: Double?
    public let height: Double?
    public let location: String?
    public let distance: Int?
    private enum CodingKeys: String, CodingKey {
        case deviceId = "DeviceId"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case height = "Height"
        case location = "Location"
        case distance = "Distance"
    }
}

struct LineChtz: Identifiable, Hashable
{
    var id: Int
    let data:[Double]
    let catCode:String
    let catDescript: String
    
}
