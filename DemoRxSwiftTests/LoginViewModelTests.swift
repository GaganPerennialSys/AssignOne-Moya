//
//  LoginViewModelTests.swift
//  DemoRxSwiftTests
//

import XCTest
@testable import DemoRxSwift
import RxSwift
import RxCocoa

class LoginViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
       // scheduler = TestScheduler(initialClock: 0)
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        disposeBag = nil
       // scheduler = nil
        viewModel = nil
        super.tearDown()
    }
    
//    func testIsLoginEnabled() {
//        // Given
//        let observer = scheduler.createObserver(Bool.self)
//
//        // When
//        viewModel.isLoginEnabled
//            .bind(to: observer)
//            .disposed(by: disposeBag)
//
//        // Then
//        scheduler.createColdObservable([.next(10, "Admin")])
//            .bind(to: viewModel.username)
//            .disposed(by: disposeBag)
//
//        scheduler.start()
//
//        XCTAssertEqual(observer.events, [.next(0, false), .next(10, true)])
//    }
    
    func testLoginSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Login Success")
        
        // When
        viewModel.username.accept("Admin")
        
        viewModel.login { username in
            // Then
            XCTAssertEqual(username, "Admin")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoginFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Login Failure")
        
        // When
        viewModel.username.accept("admin")
        
        viewModel.login { username in
            // Then
            XCTAssertNil(username)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
