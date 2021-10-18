//
//  LabelPresenter.swift
//  LDSExample
//
//  Created by GGsrvg on 18.10.2021.
//

import UIKit

class LabelPresenter: FieldPresenter {
    var text: String?
    var font: UIFont?
    var textColor: UIColor?
    var textAligment: NSTextAlignment
    
    internal init(text: String?, font: UIFont?, textColor: UIColor?, textAligment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAligment = textAligment
    }
}
