//
//  WeatherApi.swift
//  DemoRxSwift
//

import Foundation
import Moya

enum WeatherApi {
    case getForecast(latitude: Double, longitude: Double)
}

extension WeatherApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.open-meteo.com/v1")!
    }

    var path: String {
        switch self {
        case .getForecast:
            return "/forecast"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getForecast:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .getForecast(latitude, longitude):
            return .requestParameters(parameters: ["latitude": latitude, "longitude": longitude, "hourly": "temperature_2m"], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
