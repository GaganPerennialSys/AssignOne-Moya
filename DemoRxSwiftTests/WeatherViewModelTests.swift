//
//  WeatherViewModelTests.swift
//  DemoRxSwiftTests
//

import XCTest
import RxSwift
@testable import DemoRxSwift
import CoreLocation

class WeatherViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    func testFetchWeather() {
        let locationProviderMock = LocationProviderMock()
        let weatherServiceMock = WeatherServiceMock()

        let viewModel = WeatherViewModel(locationManager: locationProviderMock)

        let expectation = XCTestExpectation(description: "Fetch Weather Expectation")
        viewModel.fetchWeather(latitude: 37.785834, longitude: -122.406417)
        viewModel.weatherData
            .subscribe(onNext: { weatherData in
                XCTAssertNil(weatherData)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchWeatherWithError() {
        let locationProviderMock = LocationProviderMock()
        let weatherServiceMock = WeatherServiceMock()

        let viewModel = WeatherViewModel(locationManager: locationProviderMock)

        let expectation = XCTestExpectation(description: "Fetch Weather Expectation")

        viewModel.error
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetchWeather(latitude: 37.785834, longitude: -122.406417)

        wait(for: [expectation], timeout: 5.0)
    }
}
