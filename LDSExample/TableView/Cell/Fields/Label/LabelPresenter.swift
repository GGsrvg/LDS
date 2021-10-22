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
    var numberOfLines: Int
    
    internal init(
        text: String?,
        font: UIFont?,
        textColor: UIColor?,
        textAligment: NSTextAlignment,
        numberOfLines: Int = 1
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAligment = textAligment
        self.numberOfLines = numberOfLines
    }
}
