//  
//  CellViewModelTests.swift
//

import XCTest
import Apollo
@testable import CountryFlags
@testable import GraphQLCountryFlags

final class CellViewModelTests: XCTestCase {
    
    func testReset() {
        let item = HelperTests.loadListFirst()
        let vm = CellViewModel(item: item)
        
        
        let expectation = self.expectation(description: "testReset")
        vm.output.reset = {
            expectation.fulfill()
        }
        vm.input.reset?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testData() {
        let item = HelperTests.loadListFirst()
        let vm = CellViewModel(item: item)
        
        
        let expectation = self.expectation(description: "testData")
        vm.output.data = { value in
            XCTAssertEqual(value.name, "Andorra")
            XCTAssertEqual(value.flag, "🇦🇩")
            expectation.fulfill()
        }
        vm.input.ready?()
        
        self.waitForExpectations(timeout: 1)
    }
}
