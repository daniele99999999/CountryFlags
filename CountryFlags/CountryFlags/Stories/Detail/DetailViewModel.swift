//  
//  DetailViewModel.swift
//

import Foundation
import GraphQLCountryFlags

final class DetailViewModel {
    let input = Input()
    let output = Output()
    
    private let api: APIProtocol
    private let item: CountryListQuery.Data.Country
    
    init(item: CountryListQuery.Data.Country, api: APIProtocol) {
        self.item = item
        self.api = api
        
        self.input.ready = self.ready
    }
}

private extension DetailViewModel {
    func ready() {
        self.output.listData?((title: self.item.name, flag: self.item.emoji))
        self.fetchItem()
    }
}

private extension DetailViewModel {
    func fetchItem() {
        self.output.isLoading?(true)
        _ = self.api.countryDetail(item: self.item) { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let country):
                self.output.detailData?((
                    continent: "Continent: \(country?.continent.name ?? Resources.UI.Placeholders.labelValue)",
                    capital: "Capital: \(country?.capital ?? Resources.UI.Placeholders.labelValue)",
                    currency: "Currency: \(country?.currency ?? Resources.UI.Placeholders.labelValue)"
                ))
            case .failure(let error):
                self.output.detailData?((
                    continent: "Continent: \(Resources.UI.Placeholders.labelValue)",
                    capital: "Capital: \(Resources.UI.Placeholders.labelValue)",
                    currency: "Currency: \(Resources.UI.Placeholders.labelValue)"
                ))
                
                // TODO: customize with more human readable error
                
                switch error {
                case .emptyData:
                    self.output.error?("No Data Available")
                case .generic(_):
                    self.output.error?("Network Error")
                case .graphQL:
                    self.output.error?("Bad Data Available")
                }
            }
        }
    }
}

extension DetailViewModel {
    class Input {
        var ready: VoidClosure?
    }
    
    class Output {
        var listData: VoidOutputClosure<(title: String, flag: String)>?
        var isLoading: VoidOutputClosure<Bool>?
        var error: VoidOutputClosure<String>?
        var detailData: VoidOutputClosure<(continent: String, capital: String, currency: String)>?
    }
}
