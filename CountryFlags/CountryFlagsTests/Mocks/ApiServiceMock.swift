//  
//  ApiServiceMock.swift
//

import Foundation
import Apollo
import GraphQLCountryFlags
@testable import CountryFlags

class ApiServiceMock: APIProtocol {
    var _countryList: ((@escaping VoidOutputClosure<Result<[CountryListQuery.Data.Country], ApiError>>) -> Cancellable)?
    func countryList(completion: @escaping VoidOutputClosure<Result<[CountryListQuery.Data.Country], ApiError>>) -> Cancellable {
        return self._countryList!(completion)
    }
    
    var _countryDetail: ((CountryListQuery.Data.Country, @escaping VoidOutputClosure<Result<CountryDetailQuery.Data.Country?, ApiError>>) -> Cancellable)?
    func countryDetail(item: CountryListQuery.Data.Country, completion: @escaping VoidOutputClosure<Result<CountryDetailQuery.Data.Country?, ApiError>>) -> Cancellable {
        return self._countryDetail!(item, completion)
    }
}
