//  
//  DetailViewModelTests.swift
//

import XCTest
import Apollo
@testable import CountryFlags
@testable import GraphQLCountryFlags

final class DetailViewModelTests: XCTestCase {
    
    func testListData() {
        let item = HelperTests.loadListFirst()
        let api = ApiServiceMock()
        let vm = DetailViewModel(item: item, api: api)
        
        
        let expectation = self.expectation(description: "testListData")
        api._countryDetail = { _, completion in
            completion(.success(HelperTests.loadDetail()))
            return EmptyCancellable()
        }
        vm.output.listData = { value in
            XCTAssertEqual(value.title, "Andorra")
            XCTAssertEqual(value.flag, "🇦🇩")
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsLoadingSuccess() {
        let item = HelperTests.loadListFirst()
        let api = ApiServiceMock()
        let vm = DetailViewModel(item: item, api: api)
        
        
        let expectation = self.expectation(description: "testIsLoadingSuccess")
        expectation.expectedFulfillmentCount = 2
        var callCount = 0
        api._countryDetail = { _, completion in
            completion(.success(HelperTests.loadDetail()))
            return EmptyCancellable()
        }
        vm.output.isLoading = { value in
            callCount += 1
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(callCount, 2)
    }
    
    func testIsLoadingFailure() {
        let item = HelperTests.loadListFirst()
        let api = ApiServiceMock()
        let vm = DetailViewModel(item: item, api: api)
        
        
        let expectation = self.expectation(description: "testIsLoadingFailure")
        expectation.expectedFulfillmentCount = 2
        var callCount = 0
        api._countryDetail = { _, completion in
            completion(.failure(HelperTests.networkError))
            return EmptyCancellable()
        }
        vm.output.isLoading = { value in
            callCount += 1
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(callCount, 2)
    }
    
    func testError() {
        let item = HelperTests.loadListFirst()
        let api = ApiServiceMock()
        let vm = DetailViewModel(item: item, api: api)
        
        
        let expectation = self.expectation(description: "testError")
        api._countryDetail = { _, completion in
            completion(.failure(HelperTests.networkError))
            return EmptyCancellable()
        }
        vm.output.error = { value in
            XCTAssertEqual(value, "Network Error")
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testDetailData() {
        let item = HelperTests.loadListFirst()
        let api = ApiServiceMock()
        let vm = DetailViewModel(item: item, api: api)
        
        
        let expectation = self.expectation(description: "testDetailData")
        api._countryDetail = { _, completion in
            completion(.success(HelperTests.loadDetail()))
            return EmptyCancellable()
        }
        vm.output.detailData = { value in
            XCTAssertEqual(value.continent, "Continent: Europe")
            XCTAssertEqual(value.capital, "Capital: Andorra la Vella")
            XCTAssertEqual(value.currency, "Currency: EUR")
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
}
