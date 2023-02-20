//  
//  CellViewModel.swift
//

import Foundation
import GraphQLCountryFlags

final class CellViewModel {
    let input = Input()
    let output = Output()
    
    private let item: CountryListQuery.Data.Country
    
    init(item: CountryListQuery.Data.Country) {
        self.item = item
        
        self.input.ready = self.ready
        self.input.reset = self.reset
    }
}

private extension CellViewModel {
    func ready() {
        self.output.data?((name: self.item.name, flag: self.item.emoji))
    }
    
    func reset() {
        self.output.reset?()
    }
}

extension CellViewModel {
    class Input {
        var ready: VoidClosure?
        var reset: VoidClosure?
    }
    
    class Output {
        var reset: VoidClosure?
        var data: VoidOutputClosure<(name: String, flag: String)>?
    }
}
