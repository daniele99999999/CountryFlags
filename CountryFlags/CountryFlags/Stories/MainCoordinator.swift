//  
//  MainCoordinator.swift
//

import Foundation
import UIKit
import GraphQLCountryFlags

struct MainCoordinator {
    private (set) weak var rootController: UINavigationController?
}

// MARK: Start
extension MainCoordinator: CoordinatorProtocol {
    func start() {
        self.flowList(animated: false)
    }
}

// MARK: Create
private extension MainCoordinator {
    func createList() -> UIViewController {
        let api = ApiService(url: Resources.Api.baseURL)
        let vm = ListViewModel(api: api)
        vm.output.selectedItem = { country in
            self.flowDetail(item: country)
        }
        let vc = ListViewController(viewModel: vm)
        return vc
    }
    
    func createDetail(item: CountryListQuery.Data.Country) -> UIViewController {
        let api = ApiService(url: Resources.Api.baseURL)
        let vm = DetailViewModel(item: item, api: api)
        let vc = DetailViewController(viewModel: vm)
        return vc
    }
}

// MARK: Flow
private extension MainCoordinator {
    func flowList(animated: Bool = true) {
        let vc = self.createList()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowDetail(animated: Bool = true, item: CountryListQuery.Data.Country) {
        let vc = self.createDetail(item: item)
        self.rootController?.pushViewController(vc, animated: animated)
    }
}

