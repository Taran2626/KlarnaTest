//
//  KlarnaTestTests.swift
//  KlarnaTestTests
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import XCTest
import Combine
import CoreLocation
@testable import KlarnaTest

final class KlarnaTestTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    let latitude: CLLocationDegrees = 37.2
    let longitude: CLLocationDegrees = 22.9

    override func setUp() { }
    
    override func tearDown() {
        cancellables = []
    }

    func testFetchCurrentData_Success() async {
        let expectation = XCTestExpectation(description: "Current Location Data is fetched successfully")
        let sut = WeatherViewModel(service: MockAPIService())
        await sut.getCurrentWeather(from: CLLocation(latitude: latitude,
                                                     longitude: longitude))
       
        sut.$weather.sink { weather in
            if weather.current.weather.first?.main.isEmpty == false {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func testFetchCurrentData__Error() async {
        let expectation = XCTestExpectation(description: "Current Location Data is not fetched successfully")
        let sut = WeatherViewModel(service: MockAPIService(isSuccess: false))
        await sut.getCurrentWeather(from: CLLocation(latitude: latitude,
                                                     longitude: longitude))
        
        sut.$weather.sink { weather in
            if weather.current.weather.first?.main.isEmpty == false {
                XCTFail()
            }
        }.store(in: &cancellables)
        
        sut.$errorMessage.sink { errorMsg in
            if !errorMsg.isEmpty {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 2)
    }

}

