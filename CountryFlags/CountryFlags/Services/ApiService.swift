//
//  ApiService.swift
//

import Foundation
import Apollo
import GraphQLCountryFlags

public struct ApiService {
    let networkClient: ApolloClient
    
    init(url: URL) {
        self.networkClient = ApolloClient(url: url)
    }
}

extension ApiService: APIProtocol {
    public func countryList(completion: @escaping VoidOutputClosure<Result<[CountryListQuery.Data.Country], ApiError>>) -> Cancellable {
        self.fetchData(query: CountryListQuery(), resultKeyPath: \.countries, completion: completion)
    }
    
    public func countryDetail(item: CountryListQuery.Data.Country, completion: @escaping VoidOutputClosure<Result<CountryDetailQuery.Data.Country?, ApiError>>) -> Cancellable {
        self.fetchData(query: CountryDetailQuery(code: item.code), resultKeyPath: \.country, completion: completion)
    }
}

extension ApiService {
    @discardableResult public func fetchData<Query: GraphQLQuery, T>(query: Query, resultKeyPath: KeyPath<Query.Data, T>, completion: @escaping VoidOutputClosure<Result<T, ApiError>>) -> Cancellable {
        self.networkClient.fetch(query: query) { result in
            switch result {
            case .success(let response):
                if let errors = response.errors, !errors.isEmpty {
                    completion(.failure(.graphQL))
                } else {
                    guard let data = response.data else {
                        completion(.failure(.emptyData))
                        return
                    }
                    completion(.success(data[keyPath: resultKeyPath]))
                }
            case .failure(let error):
                completion(.failure(.generic(error)))
            }
        }
    }
}
