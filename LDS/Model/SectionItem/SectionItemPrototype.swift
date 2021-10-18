//
//  SectionItemPrototype.swift
//  LDS
//
//  Created by GGsrvg on 07.10.2021.
//

import Foundation

public protocol SectionItemPrototype: AnyObject, Equatable {
    associatedtype Header
    associatedtype Row: Equatable
    associatedtype Footer
    
    var header: Header { get set }
    var rows: [Row] { get }
    var footer: Footer { get set }
    
    // append
    func appendRow(_ newRow: Row)
    
    func appendRows(_ newRows: [Row])
    
    // insert
    func insertRow(_ newRow: Row, at i: Int)
    
    func insertRow(_ newRow: Row, after oldRow: Row)
    
    func insertRow(_ newRow: Row, before oldRow: Row)
    
    func insertRows(_ newRows: [Row], at i: Int)
    
    func insertRows(_ newRows: [Row], after oldRow: Row)
    
    func insertRows(_ newRows: [Row], before oldRow: Row)
    
    // replacing
    func replaceRow(_ newRow: Row, at i: Int)
    
    func replaceRow(_ newRow: Row, at oldRow: Row)
    
    // removing
    func removeRow(_ rows: [Row])
    
    func removeAllRows()
    
    // MARK: -
    
    var delegate: SectionItemDelegate? { get set }
    /**
     Have a weak reference to Observable Array Abstract.
     
     This is necessary to notify about changes in rows.
     */
    var observableArray: ObservableArrayNotify? { get set }
}
