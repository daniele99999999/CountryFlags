//  
//  ListViewController.swift
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    let rootView = ListView()
    
    private (set) var viewModel: ListViewModel
    private (set) var dataSource: ListDatasource

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        self.dataSource = ListDatasource(provider: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.ready?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showBackArrowOnly()
    }
}

private extension ListViewController {
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.rootView.setTableView(delegate: self, dataSource: self.dataSource)
    }
    
    func setupBindings() {
        self.viewModel.output.title = Self.bindOnMain { [weak self] text in
            self?.title = text
        }
        
        self.viewModel.output.isLoading = Self.bindOnMain { [weak self] isLoading in
            if isLoading {
                self?.rootView.startLoader()
            } else {
                self?.rootView.stopLoader()
            }
        }

        self.viewModel.output.error = Self.bindOnMain { [weak self] error in
            self?.showErrorAlert(title: nil, message: error)
        }
        
        self.viewModel.output.addItems = Self.bindOnMain { [weak self] indexPaths in
            self?.rootView.addItems(indexPaths: indexPaths)
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.viewModel.input.selectedItem?(indexPath.row)
    }
}
