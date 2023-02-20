//  
//  CountryDatasourceProviderProtocol.swift
//

import Foundation

protocol CountryDatasourceProviderProtocol {
    var itemsCount: Int { get }
    func itemViewModel(index: Int) -> CellViewModel
}
