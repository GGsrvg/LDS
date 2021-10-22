//
//  QuestionnaireViewModel.swift
//  LDSExample
//
//  Created by GGsrvg on 22.10.2021.
//

import Foundation
import LDS
import UIKit

protocol QuestionnaireViewModelDelegate: AnyObject {
    func selectPhoto()
}

class QuestionnaireViewModel {
    
    weak var delegate: QuestionnaireViewModelDelegate?
    
    typealias SectionItemType = SectionItem<Void, FieldPresenter, Void>
    
    let fields: LDS.ObservableDataSource<SectionItemType> = .init()
    
    private let userImage = ImagePresenter(image: nil, contentMode: .scaleToFill, aspectRatio: 1/1)
    
    init() {
        self.fields.set([
            .init(
                header: (),
                rows: [
                    self.userImage,
                    ButtonPresenter(
                        image: nil,
                        text: "Select photo",
                        font: .systemFont(ofSize: 16, weight: .bold),
                        textColor: .black,
                        textAligment: .center,
                        contentInsets: nil,
                        tapHandler: { presenter in
                            self.delegate?.selectPhoto()
                        })
                ],
                footer: ()
            ),
            .init(
                header: (),
                rows: [
                    LabelPresenter(
                        text: "First Name",
                        font: .systemFont(ofSize: 14),
                        textColor: .gray,
                        textAligment: .left
                    ),
                    TextFieldPresenter(
                        text: nil,
                        placeholder: "Your first name",
                        font: .systemFont(ofSize: 16),
                        textColor: .black,
                        textAligment: .left
                    ),
                    LabelPresenter(
                        text: "Second Name",
                        font: .systemFont(ofSize: 14),
                        textColor: .gray,
                        textAligment: .left
                    ),
                    TextFieldPresenter(
                        text: nil,
                        placeholder: "Your second name",
                        font: .systemFont(ofSize: 16),
                        textColor: .black,
                        textAligment: .left
                    ),
                ],
                footer: ()
            ),
        ])
    }
    
    func setSelectedPhoto(_ image: UIImage?) {
        userImage.image = image
        self.fields.updateRow(userImage)
    }
}
