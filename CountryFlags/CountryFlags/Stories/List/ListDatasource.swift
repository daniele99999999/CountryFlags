//  
//  ListDatasource.swift
//

import Foundation
import UIKit

final class ListDatasource: NSObject {
    private let provider: CountryDatasourceProviderProtocol
    
    init(provider: CountryDatasourceProviderProtocol) {
        self.provider = provider
    }
}

extension ListDatasource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.provider.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(className: CellView.self, indexPath: indexPath)
        let cellViewModel = self.provider.itemViewModel(index: indexPath.row)
        cell.set(viewModel: cellViewModel)
        return cell
    }
}
