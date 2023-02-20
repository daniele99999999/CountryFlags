//  
//  HelperTests.swift
//

import Foundation
import ApolloTestSupport
@testable import CountryFlags
@testable import GraphQLCountryFlags
@testable import GraphQLCountryFlagsTestMocks

class HelperTests {
    struct FakeError: Error {}
    static let emptyDataError = ApiError.emptyData
    static let networkError = ApiError.generic(FakeError())
    static let graphQLError = ApiError.graphQL
    
    static func loadList() -> [CountryListQuery.Data.Country] {
        let mock = Mock<Query>(
            countries: [
                Mock<Country>(
                    code: "AD",
                    emoji: "🇦🇩",
                    name: "Andorra"
                ),
                Mock<Country>(
                    code: "AE",
                    emoji: "🇦🇪",
                    name: "United Arab Emirates"
                ),
                Mock<Country>(
                    code: "AF",
                    emoji: "🇦🇫",
                    name: "Afghanistan"
                )
            ]
        )
        return CountryListQuery.Data.from(mock).countries
    }
    
    static func loadListFirst() -> CountryListQuery.Data.Country {
        return self.loadList().first!
    }
    
    static func loadListLast() -> CountryListQuery.Data.Country {
        return self.loadList().last!
    }
    
    static func loadDetail() -> CountryDetailQuery.Data.Country {
        let mock = Mock<Query>(
            country: Mock<Country>(
                capital: "Andorra la Vella",
                continent: Mock<Continent>(name: "Europe"),
                currency: "EUR"
            )
        )
        return CountryDetailQuery.Data.from(mock).country!
    }
}
