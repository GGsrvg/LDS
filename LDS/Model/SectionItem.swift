//
//  SectionItem.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public class SectionItem<H, R, F> {
    public var header: H
    public var rows: [R]
    public var footer: F
    
    init(header: H, rows: [R], footer: F) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}
