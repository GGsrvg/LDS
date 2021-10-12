//
//  ObservableArrayNotify.swift
//  LDS
//
//  Created by GGsrvg on 09.10.2021.
//

import Foundation

/**
 Protocol for notify on change array
 */
public protocol ObservableArrayNotify: AnyObject {
    func notifyReload()
    
    func notifyAdd(at indexSet: IndexSet)
    
    func notifyInsert(at indexSet: IndexSet)
    
    func notifyUpdate(at indexSet: IndexSet)
    
    func notifyRemove(at indexSet: IndexSet)
    
    func notifyHeader(section: Int)
    
    func notifyFooter(section: Int)
    
    func notifyAddRow(at indexPaths: [IndexPath])
    
    func notifyInsertRow(at indexPaths: [IndexPath])
    
    func notifyUpdateRow(at indexPaths: [IndexPath])
    
    func notifyRemoveRow(at indexPaths: [IndexPath])
    // TODO: add functions moveCell/moveSection with second param before/after
}
