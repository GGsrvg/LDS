//
//  TextFieldPresenter.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import UIKit

class TextFieldPresenter: FieldPresenter {
    var text: String?
    var placeholder: String?
    var font: UIFont?
    var textColor: UIColor?
    var textAligment: NSTextAlignment
    
    internal init(text: String?, placeholder: String?, font: UIFont?, textColor: UIColor?, textAligment: NSTextAlignment) {
        self.text = text
        self.placeholder = placeholder
        self.font = font
        self.textColor = textColor
        self.textAligment = textAligment
    }
}
