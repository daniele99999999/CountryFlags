//  
//  ListView.swift
//

import Foundation
import UIKit

final class ListView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorCBCBCB
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.registerCell(className: CellView.self)
        view.rowHeight = 100
        view.contentInset = .init(top: 8, left: 0, bottom: -8, right: 0)
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.color = Resources.UI.Colors.color000000
        view.stopAnimating()
        return view
    }()

    init() {
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .clear
        
        self.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.tableView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.loaderView)
        NSLayoutConstraint.activate([
            self.loaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.loaderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.loaderView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.loaderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension ListView {
    func setTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }

    func updateView() {
        self.tableView.reloadData()
    }
    
    func addItems(indexPaths: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
    }

    func startLoader() {
        self.loaderView.startAnimating()
        self.loaderView.isHidden = false
    }

    func stopLoader() {
        self.loaderView.stopAnimating()
        self.loaderView.isHidden = true
    }
}
