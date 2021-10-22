//
//  TextFieldTableViewCell.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var presenter: LabelPresenter? { didSet {
        guard let presenter = presenter
        else {
            textField.text = nil
            textField.textColor = nil
            textField.textAlignment = .natural
            textField.font = nil
            return
        }
        
        textField.text = presenter.text
        textField.textColor = presenter.textColor
        textField.textAlignment = presenter.textAligment
        textField.font = presenter.font
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
        self.contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
        ])
    }
}
