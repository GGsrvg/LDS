//
//  MainViewModel.swift
//  LDSExample
//
//  Created by GGsrvg on 22.10.2021.
//

import Foundation
import LDS

class MainViewModel {
    typealias SectionItemType = SectionItem<Void, String, Void>
    
    
    let observable: LDS.ObservableDataSource<SectionItemType> = .init()
    private lazy var section: SectionItemType = .init(header: (), rows: [
        "Questionnaire",
        "Sorted collection",
        "Sorted table",
    ], footer: ())
    
    init() {
        observable.set([section])
    }
}
