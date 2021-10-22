//
//  LabelTableViewCell.swift
//  LDSExample
//
//  Created by GGsrvg on 18.10.2021.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var presenter: LabelPresenter? { didSet {
        guard let presenter = presenter
        else {
            label.text = nil
            label.textColor = nil
            label.textAlignment = .natural
            label.font = nil
            label.numberOfLines = 0
            return
        }
        
        label.text = presenter.text
        label.textColor = presenter.textColor
        label.textAlignment = presenter.textAligment
        label.font = presenter.font
        label.numberOfLines = presenter.numberOfLines
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override func prepareForReuse() {
        presenter = nil
    }
    
    private func setView() {
        self.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
        ])
    }
}
