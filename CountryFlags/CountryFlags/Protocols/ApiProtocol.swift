//
//  ApiProtocol.swift
//

import Foundation
import Apollo
import GraphQLCountryFlags

public protocol APIProtocol {
    func countryList(completion: @escaping VoidOutputClosure<Result<[CountryListQuery.Data.Country], ApiError>>) -> Cancellable
    func countryDetail(item: CountryListQuery.Data.Country, completion: @escaping VoidOutputClosure<Result<CountryDetailQuery.Data.Country?, ApiError>>) -> Cancellable
}
