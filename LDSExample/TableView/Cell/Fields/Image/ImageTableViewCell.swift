//
//  ImageTableViewCell.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    private var aspectRatioConstraint: NSLayoutConstraint?
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var presenter: ImagePresenter? { didSet {
        if let aspectRatioConstraint = self.aspectRatioConstraint {
            mainImageView.removeConstraint(aspectRatioConstraint)
        }
        
        guard let presenter = presenter
        else {
            mainImageView.image = nil
            mainImageView.contentMode = .scaleToFill
            return
        }
        
        mainImageView.image = presenter.image
        mainImageView.contentMode = presenter.contentMode
        
        
        let aspectRatioConstraint = mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor, multiplier: presenter.aspectRatio)
        aspectRatioConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([aspectRatioConstraint])
        self.aspectRatioConstraint = aspectRatioConstraint
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
        self.contentView.addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
        ])
    }
}

