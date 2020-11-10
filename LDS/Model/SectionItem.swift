//
//  SectionItem.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

class SectionItem<H, R, F> {
    var header: H
    var rows: [R]
    var footer: F
    
    init(header: H, rows: [R], footer: F) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}
