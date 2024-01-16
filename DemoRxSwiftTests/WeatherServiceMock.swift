//
//  WeatherServiceMock.swift
//  DemoRxSwiftTests
//


import XCTest
import RxSwift
@testable import DemoRxSwift
import CoreLocation

class WeatherServiceMock {
    let error: Error?

    init(error: Error? = nil) {
        self.error = error
    }

    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherData?, Error?) -> Void) {
        if let error = error {
            completion(nil, error)
        } else {
            // Provide mock WeatherData for testing
            let mockHourlyData = Hourly(time: ["12:00 PM", "1:00 PM"], temperature2M: [20.0, 22.0])
            let mockHourlyUnits = HourlyUnits(time: "hours", temperature2M: "°C")
            let mockWeatherData = WeatherData(
                latitude: latitude,
                longitude: longitude,
                generationtimeMS: 123456789,
                utcOffsetSeconds: 3600,
                timezone: "UTC",
                timezoneAbbreviation: "UTC",
                elevation: 0, 
                hourlyUnits: mockHourlyUnits,
                hourly: mockHourlyData
            )
            completion(mockWeatherData, nil)
        }
    }
}
