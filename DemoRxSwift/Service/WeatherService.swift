//
//  WeatherService.swift
//  DemoRxSwift
//

import Foundation
import Moya
import RxSwift

class WeatherService {
    static let shared = WeatherService()
    private let provider = MoyaProvider<WeatherApi>()

    private init() {}

    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherData?, Error?) -> Void) {
        provider.rx.request(.getForecast(latitude: latitude, longitude: longitude))
            .subscribe { event in
                    do {
                        let decoder = JSONDecoder()
                        let weatherData = try decoder.decode(WeatherData.self, from: event.data)
                        completion(weatherData, nil)
                    } catch {
                        completion(nil, error)
                    }
            } onFailure: { error in
                completion(nil, error)
            } onDisposed: {
                completion(nil, nil)
            }

    }
}
