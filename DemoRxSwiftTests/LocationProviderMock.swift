//
//  LocationProviderMock.swift
//  DemoRxSwiftTests
//

import XCTest
import RxSwift
@testable import DemoRxSwift
import CoreLocation

class LocationProviderMock: LocationProvider {
    let locationUpdate: Observable<CLLocation> = Observable.empty()

    func startUpdatingLocation() {
        // Do nothing for testing
    }
}
