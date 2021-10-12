//
//  ObservableArrayAbstract.swift
//  LDS
//
//  Created by GGsrvg on 19.05.2021.
//

import Foundation

public class ObservableArrayAbstract<Row>: ObservableArraySubscribe where Row : RowItem  {
    
    var callbacks: [ObservableArrayDelegate] = []
    
    init() { }
    
    public func addCallback(_ callback: ObservableArrayDelegate) {
        guard !callbacks.contains(where: { $0 === callback })
        else { return }
        
        callbacks.append(callback)
    }
    
    public func removeCallback(_ callback: ObservableArrayDelegate) {
        callbacks.removeAll(where: { $0 === callback })
    }
    
    public func numberOfSections() -> Int { fatalError("Need override \(#function)") }
    
    public func numberOfRowsInSection(_ section: Int) -> Int { fatalError("Need override \(#function)") }
    
    public func getRow(at indexPath: IndexPath) -> Row? { fatalError("Need override \(#function)") }
}

// work with updating
extension ObservableArrayAbstract: ObservableArrayNotify {
    public func notifyReload() {
        callbacks.forEach {
            $0.reload()
        }
    }
    
    public func notifyAdd(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.addSections(at: indexSet)
        }
    }
    
    public func notifyInsert(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.insertSections(at: indexSet)
        }
    }
    
    public func notifyUpdate(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.updateSections(at: indexSet)
        }
    }
    
    public func notifyRemove(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.removeSections(at: indexSet)
        }
    }
    
    public func notifyHeader(section: Int) {
        callbacks.forEach {
            $0.changeHeader(section: section)
        }
    }
    
    public func notifyFooter(section: Int) {
        callbacks.forEach {
            $0.changeFooter(section: section)
        }
    }
    
    public func notifyAddRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.addCells(at: indexPaths)
        }
    }
    
    public func notifyInsertRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.insertCells(at: indexPaths)
        }
    }
    
    public func notifyUpdateRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.updateCells(at: indexPaths)
        }
    }
    
    public func notifyRemoveRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.removeCells(at: indexPaths)
        }
    }
}
