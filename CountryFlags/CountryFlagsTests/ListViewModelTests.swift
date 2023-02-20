//  
//  ListViewModelTests.swift
//

import XCTest
import Apollo
@testable import CountryFlags
@testable import GraphQLCountryFlags

final class ListViewModelTests: XCTestCase {
    
    func testTitle() {
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)
        
        
        let expectation = self.expectation(description: "testTitle")
        api._countryList = { completion in
            completion(.success(HelperTests.loadList()))
            return EmptyCancellable()
        }
        vm.output.title = { value in
            XCTAssertEqual(value, "Country List")
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsLoadingSuccess() {
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)

        
        let expectation = self.expectation(description: "testIsLoadingSuccess")
        expectation.expectedFulfillmentCount = 2
        var callCount = 0
        api._countryList = { completion in
            completion(.success(HelperTests.loadList()))
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
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)

        
        let expectation = self.expectation(description: "testIsLoadingFailure")
        expectation.expectedFulfillmentCount = 2
        var callCount = 0
        api._countryList = { completion in
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
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)

        
        let expectation = self.expectation(description: "testError")
        api._countryList = { completion in
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
    
    func testAddItems() {
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)

        
        let expectation = self.expectation(description: "testAddItems")
        api._countryList = { completion in
            completion(.success(HelperTests.loadList()))
            return EmptyCancellable()
        }
        vm.output.addItems = { value in
            XCTAssertEqual(value.count, 3)
            XCTAssertEqual(value.first!, IndexPath(row: 0, section: 0))
            XCTAssertEqual(value.last!, IndexPath(row: value.count-1, section: 0))
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testSelectedItem() {
        let api = ApiServiceMock()
        let vm = ListViewModel(api: api)
        
        
        let expectation = self.expectation(description: "testSelectedItem")
        expectation.expectedFulfillmentCount = 2
        api._countryList = { completion in
            completion(.success(HelperTests.loadList()))
            return EmptyCancellable()
        }
        vm.output.addItems = { value in
            expectation.fulfill()
        }
        vm.input.ready?()
        vm.output.selectedItem = { value in
            expectation.fulfill()
            XCTAssertEqual(value.code, "AD")
            XCTAssertEqual(value.name, "Andorra")
            XCTAssertEqual(value.emoji, "🇦🇩")
        }
        vm.input.selectedItem?(0)
        
        self.waitForExpectations(timeout: 1)
    }
}
