//
//  WeatherbitStructs.swift
//  WeatherbitTesting
//
//  Created by Mark Pruit on 6/22/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import Foundation

//Struct for Weatherbit
public struct Weatherbit: Codable {
    public struct Data: Codable {
        public let rh: Double?
        public let pod: String?
        public let lon: Double?
        public let pres: Double?
        public let timezone: String?
        public let obTime: String?
        public let countryCode: String?
        public let clouds: Double?
        public let ts: Double?
        public let solarRad: Double?
        public let stateCode: String?
        public let cityName: String?
        public let windSpd: Double?
        public let lastObTime: String?
        public let windCdirFull: String?
        public let windCdir: String?
        public let slp: Double?
        public let vis: Double?
        public let hAngle: Double?
        public let sunset: String?
        public let dni: Double?
        public let dewpt: Double?
        public let snow: Double?
        public let uv: Double?
        public let precip: Double?
        public let windDir: Double?
        public let sunrise: String?
        public let ghi: Double?
        public let dhi: Double?
        public let aqi: Double?
        public let lat: Double?
        public struct Weather: Codable {
            public let icon: String?
            public let code: Int?
            public let description: String?
        }
        public let weather: Weather?
        public let datetime: String?
        public let temp: Double?
        public let station: String?
        public let elevAngle: Double?
        public let appTemp: Double?
        private enum CodingKeys: String, CodingKey {
            case rh
            case pod
            case lon
            case pres
            case timezone
            case obTime = "ob_time"
            case countryCode = "country_code"
            case clouds
            case ts
            case solarRad = "solar_rad"
            case stateCode = "state_code"
            case cityName = "city_name"
            case windSpd = "wind_spd"
            case lastObTime = "last_ob_time"
            case windCdirFull = "wind_cdir_full"
            case windCdir = "wind_cdir"
            case slp
            case vis
            case hAngle = "h_angle"
            case sunset
            case dni
            case dewpt
            case snow
            case uv
            case precip
            case windDir = "wind_dir"
            case sunrise
            case ghi
            case dhi
            case aqi
            case lat
            case weather
            case datetime
            case temp
            case station
            case elevAngle = "elev_angle"
            case appTemp = "app_temp"
        }
    }
    public let data: [Data]?
    public let count: Int?
}

public struct Airquality: Codable {
    public struct Data: Codable {
        public let o3: Double?
        public let so2: Double?
        public let no2: Double?
        public let aqi: Double?
        public let co: Double?
        public let pm10: Double?
        public let pm25: Double?
    }
    public let data: [Data]
    public let cityName: String?
    public let lon: Double?
    public let timezone: String?
    public let lat: Double?
    public let countryCode: String?
    public let stateCode: String?
    private enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
        case lon
        case timezone
        case lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
}

public struct WBForecast: Codable {
    public struct Data: Codable, Identifiable {
        public let id = UUID().uuidString
        public let moonriseTs: Double?
        public let windCdir: String?
        public let rh: Double?
        public let pres: Double?
        public let highTemp: Double?
        public let sunsetTs: Double?
        public let ozone: Double?
        public let moonPhase: Double?
        public let windGustSpd: Double?
        public let snowDepth: Double?
        public let clouds: Double?
        public let ts: Double?
        public let sunriseTs: Double?
        public let appMinTemp: Double?
        public let windSpd: Double?
        public let pop: Double?
        public let windCdirFull: String?
        public let slp: Double?
        public let validDate: String?//changed from date
        public let appMaxTemp: Double?
        public let vis: Double?
        public let dewpt: Double?
        public let snow: Double?
        public let uv: Double?
        public struct Weather: Codable {
            public let icon: String?
            public let code: Double?
            public let description: String?
        }
        public let weather: Weather?
        public let windDir: Double?
        public let maxDhi: Double?//TODO: Specify the type to conforms Codable protocol Is deprecated.  Returns Null
        public let cloudsHi: Double?
        public let precip: Double?
        public let lowTemp: Double?
        public let maxTemp: Double?
        public let moonsetTs: Double?
        public let datetime: String?//CHanged from date
        public let temp: Double?
        public let minTemp: Double?
        public let cloudsMid: Double?
        public let cloudsLow: Double?
        private enum CodingKeys: String, CodingKey {
            case moonriseTs = "moonrise_ts"
            case windCdir = "wind_cdir"
            case rh
            case pres
            case highTemp = "high_temp"
            case sunsetTs = "sunset_ts"
            case ozone
            case moonPhase = "moon_phase"
            case windGustSpd = "wind_gust_spd"
            case snowDepth = "snow_depth"
            case clouds
            case ts
            case sunriseTs = "sunrise_ts"
            case appMinTemp = "app_min_temp"
            case windSpd = "wind_spd"
            case pop
            case windCdirFull = "wind_cdir_full"
            case slp
            case validDate = "valid_date"
            case appMaxTemp = "app_max_temp"
            case vis
            case dewpt
            case snow
            case uv
            case weather
            case windDir = "wind_dir"
            case maxDhi = "max_dhi"
            case cloudsHi = "clouds_hi"
            case precip
            case lowTemp = "low_temp"
            case maxTemp = "max_temp"
            case moonsetTs = "moonset_ts"
            case datetime
            case temp
            case minTemp = "min_temp"
            case cloudsMid = "clouds_mid"
            case cloudsLow = "clouds_low"
        }
    }
    public let data: [Data]?
    public let cityName: String?
    public let lon: Double?
    public let timezone: String?
    public let lat: Double?
    public let countryCode: String?
    public let stateCode: String?
    private enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
        case lon
        case timezone
        case lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
}

struct ForecastStruct: Identifiable {
       var id: Int
       let conditions: String
       let wbImage: String
       let tempHi: String
       let tempLo: String
       let forecastDate: String
   }
