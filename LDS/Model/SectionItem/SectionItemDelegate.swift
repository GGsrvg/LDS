//
//  SectionItemDelegate.swift
//  LDS
//
//  Created by GGsrvg on 15.10.2021.
//

import Foundation

public protocol SectionItemDelegate: AnyObject {
    // TODO: a more beautiful implementation is needed
    func sectionItemIndex<SIP: SectionItemPrototype>(_ sectionItem: SIP) -> Int?
}
