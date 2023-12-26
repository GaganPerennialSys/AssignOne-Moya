//
//  WeatherViewModel.swift
//  DemoRxSwift


import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class WeatherViewModel {
    private let disposeBag = DisposeBag()
    private let locationManager: LocationProvider

    // Outputs
    
    let weatherData: BehaviorRelay<WeatherData?> = BehaviorRelay(value: nil)
    
    let error: PublishRelay<Error> = PublishRelay()

    init(locationManager: LocationProvider = LocationManager.shared) {
        self.locationManager = locationManager
        bindLocationUpdates()
    }

    private func bindLocationUpdates() {
        locationManager.locationUpdate
            .subscribe(onNext: { [weak self] location in
                self?.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            })
            .disposed(by: disposeBag)

        locationManager.startUpdatingLocation()
    }

    func fetchWeather(latitude: Double, longitude: Double) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m") else {
            return
        }
        WeatherService.shared.fetchWeather(latitude: latitude, longitude: longitude) { weatherData, error in
            if let weatherData = weatherData {
                self.weatherData.accept(weatherData)
                print(weatherData)
            } else if let error = error {
                // Handle error
                self.error.accept(error)
            }
        }
    }
    
}
