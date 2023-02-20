//  
//  ListViewModel.swift
//

import Foundation
import GraphQLCountryFlags

final class ListViewModel {
    let input = Input()
    let output = Output()
    
    private let api: APIProtocol
    private var countryList: [CountryListQuery.Data.Country] = []
    
    init(api: APIProtocol) {
        self.api = api
        
        self.input.ready = self.ready
        self.input.selectedItem = self.selectedItem
    }
}

private extension ListViewModel {
    func ready() {
        self.output.title?("Country List")
        self.fetchItems()
    }
    
    func selectedItem(index: Int) {
        let item = self.countryList[index]
        self.output.selectedItem?(item)
    }
}

private extension ListViewModel {
    func fetchItems() {
        self.output.isLoading?(true)
        _ = self.api.countryList { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let countries):
                let indexPaths = (0..<countries.count).map { IndexPath(item: $0, section: 0) }
                self.countryList = countries
                self.output.addItems?(indexPaths)
            case .failure(let error):
                self.countryList = []
                
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

private extension ListViewModel {
    func cellViewModel(index: Int) -> CellViewModel {
        let item = self.countryList[index]
        return CellViewModel(item: item)
    }
}

extension ListViewModel: CountryDatasourceProviderProtocol {
    var itemsCount: Int {
        return self.countryList.count
    }
    
    func itemViewModel(index: Int) -> CellViewModel {
        return self.cellViewModel(index: index)
    }
}

extension ListViewModel {
    class Input {
        var ready: VoidClosure?
        var selectedItem: VoidOutputClosure<Int>?
    }
    
    class Output {
        var title: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var error: VoidOutputClosure<String>?
        var addItems: VoidOutputClosure<[IndexPath]>?
        var selectedItem: VoidOutputClosure<CountryListQuery.Data.Country>?
    }
}
