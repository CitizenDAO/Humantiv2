//
//  WeatheerGovStructs.swift
//  HealthKitMonitoringWorkshop
//
//  Created by Mark Pruit on 2/13/21.
//

import Foundation

public struct WeatherGovGrid: Codable {
    public let context: [String]? //TODO: Specify the type to conforms Codable protocol
    public let id: String?
    public let type: String?
    public struct Geometry: Codable {
        public let type: String?
        public let coordinates: [Double]?
    }
    public let geometry: Geometry
    public struct Properties: Codable {
        public let id: String?
        public let type: String?
        public let cwa: String?
        public let forecastOffice: String?
        public let gridId: String?
        public let gridX: Int?
        public let gridY: Int?
        public let forecast: String?
        public let forecastHourly: String?
        public let forecastGridData: String?
        public let observationStations: String?
        public struct RelativeLocation: Codable {
            public let type: String?
            public struct Geometry: Codable {
                public let type: String?
                public let coordinates: [Double]
            }
            public let geometry: Geometry
            public struct Properties: Codable {
                public let city: String?
                public let state: String?
                public struct Distance: Codable {
                    public let value: Double?
                    public let unitCode: String?
                }
                public let distance: Distance
                public struct Bearing: Codable {
                    public let value: Int?
                    public let unitCode: String?
                }
                public let bearing: Bearing?
            }
            public let properties: Properties?
        }
        public let relativeLocation: RelativeLocation?
        public let forecastZone: String?
        public let county: String?
        public let fireWeatherZone: String?
        public let timeZone: String?
        public let radarStation: String?
        private enum CodingKeys: String, CodingKey {
            case id = "@id"
            case type = "@type"
            case cwa
            case forecastOffice
            case gridId
            case gridX
            case gridY
            case forecast
            case forecastHourly
            case forecastGridData
            case observationStations
            case relativeLocation
            case forecastZone
            case county
            case fireWeatherZone
            case timeZone
            case radarStation
        }
    }
    public let properties: Properties?
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case id
        case type
        case geometry
        case properties
    }
}

public struct WeatherGovForecst: Codable {
    public let context: [String]? //TODO: Specify the type to conforms Codable protocol
    public let type: String?
    public struct Geometry: Codable {
        public let type: String?
        public let coordinates: [Double]?
    }
    public let geometry: Geometry?
    public struct Properties: Codable {
        public let updated: String?
        public let units: String?
        public let forecastGenerator: String?
        public let generatedAt: String?
        public let updateTime: String?
        public let validTimes: String?
        public struct Elevation: Codable {
            public let value: Double?
            public let unitCode: String?
        }
        public let elevation: Elevation
        public struct Period: Codable {
            public let number: Int?
            public let name: String?
            public let startTime: String?
            public let endTime: String?
            public let isDaytime: Bool?
            public let temperature: Double?
            public let temperatureUnit: String?
            public let temperatureTrend: String? //TODO: Specify the type to conforms Codable protocol
            public let windSpeed: String?
            public let windDirection: String?
            public let icon: String?
            public let shortForecast: String?
            public let detailedForecast: String?
        }
        public let periods: [Period]?
    }
    public let properties: Properties?
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type
        case geometry
        case properties
    }
}

public struct WeatherGovStations: Codable {
    public let context: [String]? //TODO: Specify the type to conforms Codable protocol
    public let type: String?
    public struct Feature: Codable {
        public let id: String?
        public let type: String?
        public struct Geometry: Codable {
            public let type: String?
            public let coordinates: [Double]?
        }
        public let geometry: Geometry?
        public struct Properties: Codable {
            public let id: String?
            public let type: String?
            public struct Elevation: Codable {
                public let value: Double?
                public let unitCode: String?
            }
            public let elevation: Elevation?
            public let stationIdentifier: String?
            public let name: String?
            public let timeZone: String?
            public let forecast: String?
            public let county: String?
            public let fireWeatherZone: String?
            private enum CodingKeys: String, CodingKey {
                case id = "@id"
                case type = "@type"
                case elevation
                case stationIdentifier
                case name
                case timeZone
                case forecast
                case county
                case fireWeatherZone
            }
        }
        public let properties: Properties?
    }
    public let features: [Feature]?
    public let observationStations: [String]?
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type
        case features
        case observationStations
    }
}

public struct WeatherGovObservations: Codable {
    public let context: [String]? //TODO: Specify the type to conforms Codable protocol
    public let id: String?
    public let type: String?
    public struct Geometry: Codable {
        public let type: String?
        public let coordinates: [Double]?
    }
    public let geometry: Geometry?
    public struct Properties: Codable {
        public let id: String?
        public let type: String?
        public struct Elevation: Codable {
            public let value: Double?
            public let unitCode: String?
        }
        public let elevation: Elevation?
        public let station: String?
        public let timestamp: String?
        public let rawMessage: String?
        public let textDescription: String?
        public let icon: String? //TODO: Specify the type to conforms Codable protocol
        public let presentWeather: [String]? //TODO: Specify the type to conforms Codable protocol
        public struct Temperature: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let temperature: Temperature?
        public struct Dewpoint: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let dewpoint: Dewpoint?
        public struct WindDirection: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let windDirection: WindDirection?
        public struct WindSpeed: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let windSpeed: WindSpeed?
        public struct WindGust: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let windGust: WindGust?
        public struct BarometricPressure: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let barometricPressure: BarometricPressure?
        public struct SeaLevelPressure: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let seaLevelPressure: SeaLevelPressure?
        public struct Visibility: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let visibility: Visibility?
        public struct MaxTemperatureLast24Hours: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String? //TODO: Specify the type to conforms Codable protocol
        }
        public let maxTemperatureLast24Hours: MaxTemperatureLast24Hours?
        public struct MinTemperatureLast24Hours: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String? //TODO: Specify the type to conforms Codable protocol
        }
        public let minTemperatureLast24Hours: MinTemperatureLast24Hours?
        public struct PrecipitationLast3Hours: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let precipitationLast3Hours: PrecipitationLast3Hours?
        public struct RelativeHumidity: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let relativeHumidity: RelativeHumidity?
        public struct WindChill: Codable {
            public let value: Double?
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let windChill: WindChill?
        public struct HeatIndex: Codable {
            public let value: Double? //TODO: Specify the type to conforms Codable protocol
            public let unitCode: String?
            public let qualityControl: String?
        }
        public let heatIndex: HeatIndex?
        public let cloudLayers: [String]? //TODO: Specify the type to conforms Codable protocol
        private enum CodingKeys: String, CodingKey {
            case id = "@id"
            case type = "@type"
            case elevation
            case station
            case timestamp
            case rawMessage
            case textDescription
            case icon
            case presentWeather
            case temperature
            case dewpoint
            case windDirection
            case windSpeed
            case windGust
            case barometricPressure
            case seaLevelPressure
            case visibility
            case maxTemperatureLast24Hours
            case minTemperatureLast24Hours
            case precipitationLast3Hours
            case relativeHumidity
            case windChill
            case heatIndex
            case cloudLayers
        }
    }
    public let properties: Properties?
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case id
        case type
        case geometry
        case properties
    }
}
