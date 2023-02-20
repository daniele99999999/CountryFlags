//  
//  CellView.swift
//

import Foundation
import UIKit

class CellView: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Resources.UI.Fonts.systemRegular(size: 18)
        view.textColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private lazy var flagLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.textAlignment = .right
        view.font = Resources.UI.Fonts.systemRegular(size: 50)
        view.textColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private var viewModel: CellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: CellViewModel) {
        self.viewModel = viewModel
        self.setupBindings()
        self.viewModel?.input.ready?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel?.input.reset?()
    }
}

private extension CellView {
    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        self.containerView.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.nameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16)
        ])
        
        self.containerView.addSubview(self.flagLabel)
        NSLayoutConstraint.activate([
            self.flagLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.flagLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            self.flagLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16),
            self.flagLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 0),
            self.flagLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupBindings() {
        self.viewModel?.output.reset = Self.bindOnMain { [weak self] in
            self?.nameLabel.text = nil
            self?.flagLabel.text = nil
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.data = Self.bindOnMain { [weak self] data in
            self?.nameLabel.text = data.name
            self?.flagLabel.text = data.flag
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
    }
}


