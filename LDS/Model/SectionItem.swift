//
//  SectionItem.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public class SectionItem<H, R, F> where R: Equatable {
    /**
     Header
     */
    public var header: H
    
    /**
     Rows
     
     For change array, need use:
        - appendRow(_ newRow: R)
        - appendRows(contentsOf newRows: [R])
        - etc.
     */
    public private(set) var rows: [R]
    
    /**
     Footer
     */
    public var footer: F
    
    /**
     Have a weak reference to Observable Array Abstract.
     
     This is necessary to notify about changes in rows.
     */
    private weak var observableArray: ObservableArrayAbstract<R>?
    
    public init(header: H, rows: [R], footer: F) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

// MARK: - work with rows
extension SectionItem {
    public func appendRow(_ newRow: R) {
        self.rows.append(newRow)
//        self.observableArray?.notifyAddRow(at: <#T##[IndexPath]#>)
    }
    
    public func appendRows(contentsOf newRows: [R]) {
        self.rows.append(contentsOf: newRows)
    }
    
    public func insert(_ newElement: R, at i: Int) {
        self.rows.insert(newElement, at: i)
    }
    
    public func insert(contentsOf newElements: [R], at i: Int) {
        self.rows.insert(contentsOf: newElements, at: i)
    }
    
    public func remove(_ rows: [R]) {
        self.rows.removeAll(where: { rows.contains($0) })
    }
    
    public func removeAll() {
        self.rows.removeAll()
    }
    
    // sugar
}

extension SectionItem {
    func findIndex(_ row: R) -> Int? {
        let index = self.rows.firstIndex(where: { $0 == row})
        return index
    }
}
