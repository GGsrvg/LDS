//
//  ButtonTableViewCell.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var presenter: ButtonPresenter? { didSet {
        guard let presenter = presenter
        else {
            button.setImage(nil, for: .normal)
            button.setTitle(nil, for: .normal)
            button.titleLabel?.textColor = nil
            button.titleLabel?.textAlignment = .natural
            button.titleLabel?.font = nil
            return
        }
        
        if #available(iOS 15.0, *) {
            if let contentInsets = presenter.contentInsets {
                button.configuration?.contentInsets = contentInsets
            } else {
                button.configuration?.setDefaultContentInsets()
            }
            
        } else {
            button.contentEdgeInsets = .init(
                top: presenter.contentInsets?.top ?? 0,
                left: presenter.contentInsets?.leading ?? 0,
                bottom: presenter.contentInsets?.bottom ?? 0,
                right: presenter.contentInsets?.trailing ?? 0
            )
            
        }
        
        button.setImage(presenter.image, for: .normal)
        button.setTitle(presenter.text, for: .normal)
        button.titleLabel?.textColor = presenter.textColor
        button.titleLabel?.textAlignment = presenter.textAligment
        button.titleLabel?.font = presenter.font
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        presenter = nil
    }
    
    private func setView() {
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
        ])
    }
}

