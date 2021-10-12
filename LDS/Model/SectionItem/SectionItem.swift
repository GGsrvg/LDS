//
//  SectionItem.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//`

import Foundation

public class SectionItem<H, R, F>: SectionItemPrototype where R: RowItem {
    
    public static func == (lhs: SectionItem<H, R, F>, rhs: SectionItem<H, R, F>) -> Bool {
        lhs === rhs
    }
    
    public typealias Header = H
    public typealias Row = R
    public typealias Footer = F
    
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
    private weak var observableArray: ObservableArrayNotify?
    
    var index: Int = 0
    
    public init(header: H, rows: [R], footer: F) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }

    // MARK: - work with rows
//    public func appendRow(_ newRow: R) {
//        self.rows.append(newRow)
//        self.observableArray?.notifyAddRow(at: [
//            IndexPath(row: self.rows.count - 1, section: index)
//        ])
//    }
//
//    public func appendRows(contentsOf newRows: [R]) {
//        self.rows.append(contentsOf: newRows)
//        var indexPath = IndexPath(row: rows.count, section: self.index)
//
//        var addIndexPaths: [IndexPath] = []
//        for _ in newRows {
//            indexPath.row += 1
//            addIndexPaths.append(indexPath)
//        }
//        self.observableArray?.notifyAddRow(at: addIndexPaths)
//    }
//
//    public func insert(_ newElement: R, at i: Int) {
//        self.rows.insert(newElement, at: i)
//    }
//
//    public func insert(contentsOf newElements: [R], at i: Int) {
//        self.rows.insert(contentsOf: newElements, at: i)
//    }
//
//    public func remove(_ rows: [R]) {
//        self.rows.removeAll(where: { rows.contains($0) })
//    }
//
//    public func removeAll() {
//        self.rows.removeAll()
////        self.observableArray?.notifyRemoveRow(at: .)
//    }
    
    
    public func appendRow(_ newRow: R) {
        newRow.delegate = self
    }
    
    public func appendRows(_ newRows: [R]) {
        
    }
    
    public func insertRow(_ newRow: R, at i: Int) {
            
    }
    
    public func insertRows(_ newRows: [R], at i: Int) {
        
    }
    
    public func insertRow(_ newRow: R, after oldRow: R) {
        
    }
    
    public func insertRows(_ newRows: [R], after oldRow: R) {
        
    }
    
    public func insertRow(_ newRow: R, before oldRow: R) {
        
    }
    
    public func insertRows(_ newRows: [R], before oldRow: R) {
        
    }
    
    public func replaceRow(_ newRow: R, at i: Int) {
        
    }
    
    public func replaceRow(_ newRow: R, at oldRow: R) {
            
    }
    
    public func removeRow(_ newRows: [R]) {
            
    }
    
    public func removeAllRows() {
        
    }
}

extension SectionItem: RowDelegate {
    public func reload(_ row: RowItem) -> Bool {
        return false
    }
}
