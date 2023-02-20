//  
//  DetailViewController.swift
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    let rootView = DetailView()
    
    private (set) var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
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

private extension DetailViewController {
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupBindings() {
        self.viewModel.output.listData = Self.bindOnMain { [weak self] data in
            self?.title = data.title
            self?.rootView.updateFlag(text: data.flag)
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
        
        self.viewModel.output.detailData = Self.bindOnMain { [weak self] data in
            self?.rootView.updateContinent(text: data.continent)
            self?.rootView.updateCapital(text: data.capital)
            self?.rootView.updateCurrency(text: data.currency)
        }
    }
}
