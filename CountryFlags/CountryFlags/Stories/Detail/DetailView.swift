//  
//  DetailView.swift
//

import Foundation
import UIKit

final class DetailView: UIView {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        return view
    }()
    
    private lazy var flagLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemBold(size: 150)
        view.textColor = Resources.UI.Colors.color000000
        view.numberOfLines = 1
        view.textAlignment = .center
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.text = nil
        return view
    }()
    
    private lazy var continentLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemBold(size: 18)
        view.textColor = Resources.UI.Colors.color000000
        view.numberOfLines = 1
        view.textAlignment = .left
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.text = nil
        return view
    }()
    
    private lazy var capitalLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemBold(size: 18)
        view.textColor = Resources.UI.Colors.color000000
        view.numberOfLines = 1
        view.textAlignment = .left
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.text = nil
        return view
    }()
    
    private lazy var currencyLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemBold(size: 18)
        view.textColor = Resources.UI.Colors.color000000
        view.numberOfLines = 1
        view.textAlignment = .left
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.text = nil
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
        self.backgroundColor = Resources.UI.Colors.colorCBCBCB
        
        self.addSubview(self.scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.scrollView.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        self.contentView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        
        self.containerView.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.stackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16)
        ])
        
        self.stackView.addArrangedSubview(self.flagLabel)
        
        self.stackView.addArrangedSubview(self.continentLabel)
        
        self.stackView.addArrangedSubview(self.capitalLabel)
        
        self.stackView.addArrangedSubview(self.currencyLabel)
        
        self.addSubview(self.loaderView)
        NSLayoutConstraint.activate([
            self.loaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.loaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.loaderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.loaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension DetailView {
    func startLoader() {
        self.loaderView.startAnimating()
        self.loaderView.isHidden = false
    }

    func stopLoader() {
        self.loaderView.stopAnimating()
        self.loaderView.isHidden = true
    }
    
    func updateFlag(text: String) {
        self.flagLabel.text = text
    }
    
    func updateContinent(text: String) {
        self.continentLabel.text = text
    }
    
    func updateCapital(text: String) {
        self.capitalLabel.text = text
    }
    
    func updateCurrency(text: String) {
        self.currencyLabel.text = text
    }
}
