//
//  SectionItem.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//`

import Foundation

public class SectionItem<H, R, F>: SectionItemPrototype where R: Equatable {
    
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
    
    
    public weak var delegate: SectionItemDelegate?
    /**
     Have a weak reference to Observable Array Abstract.
     
     This is necessary to notify about changes in rows.
     */
    public weak var observableArray: ObservableArrayNotify?
    
    public init(header: H, rows: [R], footer: F) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }

    // MARK: - work with rows
    public func appendRow(_ newRow: R) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.append(newRow)
            return
        }
        
        let itemIndex = self.rows.count
        
        self.rows.append(newRow)
        
        self.observableArray?.notifyAddRow(at: [.init(row: itemIndex, section: sectionItemIndex)])
    }
    
    public func appendRows(_ newRows: [R]) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.append(contentsOf: newRows)
            return
        }
        
        var indexPath = IndexPath(row: self.rows.count, section: sectionItemIndex)
        
        var addIndexPaths: [IndexPath] = []
        
        for _ in newRows {
            addIndexPaths.append(indexPath)
            indexPath.row += 1
        }
        
        self.rows.append(contentsOf: newRows)
        
        self.observableArray?.notifyAddRow(at: addIndexPaths)
    }
    
    public func insertRow(_ newRow: R, at i: Int) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.insert(newRow, at: i)
            return
        }
        
        let indexPath = IndexPath(row: i, section: sectionItemIndex)
        
        self.rows.insert(newRow, at: i)
        
        self.observableArray?.notifyInsertRow(at: [indexPath])
    }
    
    public func insertRow(_ newRow: R, after oldRow: R) {
        guard var index = self.rows.firstIndex(of: oldRow)
        else { return }
        
        index += 1
        
        self.insertRow(newRow, at: index)
    }
    
    public func insertRow(_ newRow: R, before oldRow: R) {
        guard let index = self.rows.firstIndex(of: oldRow)
        else { return }
        
        self.insertRow(newRow, at: index)
    }
    
    public func insertRows(_ newRows: [R], at i: Int) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.insert(contentsOf: newRows, at: i)
            return
        }
        
        var indexPath = IndexPath(row: self.rows.count, section: sectionItemIndex)
        
        var insertIndexPaths: [IndexPath] = []
        
        for _ in newRows {
            insertIndexPaths.append(indexPath)
            indexPath.row += 1
        }
        
        self.rows.insert(contentsOf: newRows, at: i)
        
        self.observableArray?.notifyInsertRow(at: insertIndexPaths)
    }
    
    public func insertRows(_ newRows: [R], after oldRow: R) {
        guard var index = self.rows.firstIndex(of: oldRow)
        else { return }
        
        index += 1
        
        self.insertRows(newRows, at: index)
    }
    
    public func insertRows(_ newRows: [R], before oldRow: R) {
        guard let index = self.rows.firstIndex(of: oldRow)
        else { return }
        
        self.insertRows(newRows, at: index)
    }
    
    public func replaceRow(_ newRow: R, at i: Int) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows[i] = newRow
            return
        }
        
        self.rows[i] = newRow
        
        self.observableArray?.notifyUpdateRow(at: [IndexPath(row: i, section: sectionItemIndex)])
    }
    
    public func replaceRow(_ newRow: R, at oldRow: R) {
        guard let index = self.rows.firstIndex(of: oldRow)
        else { return }
        
        self.replaceRow(newRow, at: index)
    }
    
    public func removeRow(_ rows: [R]) {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.removeAll { rows.contains($0) }
            return
        }
        // TODO: need replace to single cycle
        let removedIndexPaths: [IndexPath] = self.rows
            .enumerated()
            .compactMap {
                guard rows.contains($0.element) else { return nil }
                return IndexPath(row: $0.offset, section: sectionItemIndex)
            }
        
        self.rows.removeAll { rows.contains($0) }
        
        self.observableArray?.notifyRemoveRow(at: removedIndexPaths)
    }
    
    public func removeAllRows() {
        guard let sectionItemIndex = delegate?.sectionItemIndex(self)
        else {
            self.rows.removeAll()
            return
        }
        
        let removedIndexPaths: [IndexPath] = self.rows
            .enumerated()
            .compactMap {
                return IndexPath(row: $0.offset, section: sectionItemIndex)
            }
        
        self.rows.removeAll()
        
        self.observableArray?.notifyRemoveRow(at: removedIndexPaths)
    }
}
