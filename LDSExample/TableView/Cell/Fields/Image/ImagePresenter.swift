//
//  ImagePresenter.swift
//  LDSExample
//
//  Created by GGsrvg on 19.10.2021.
//

import Foundation
import UIKit

class ImagePresenter: FieldPresenter {
    var image: UIImage?
    var contentMode: UIView.ContentMode
    
    /// 4 : 3
    /// 16 : 9
    var aspectRatio: CGFloat
    
    internal init(
        image: UIImage?,
        contentMode: UIView.ContentMode,
        aspectRatio: CGFloat
    ) {
        self.image = image
        self.contentMode = contentMode
        self.aspectRatio = aspectRatio
    }
}
