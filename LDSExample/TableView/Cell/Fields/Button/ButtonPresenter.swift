//
//  ButtonPresenter.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import UIKit

class ButtonPresenter: FieldPresenter {
    var image: UIImage?
    var text: String?
    var font: UIFont?
    var textColor: UIColor?
    var textAligment: NSTextAlignment
    var contentInsets: NSDirectionalEdgeInsets?
    
    internal init(
        image: UIImage?,
        text: String?,
        font: UIFont?,
        textColor: UIColor?,
        textAligment: NSTextAlignment,
        contentInsets: NSDirectionalEdgeInsets?
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAligment = textAligment
        self.contentInsets = contentInsets
    }
}
