//
//  ObservableArrayAbstract.swift
//  LDS
//
//  Created by GGsrvg on 19.05.2021.
//

import Foundation

public class ObservableArrayAbstract<Row>: ObservableArray where Row : Equatable  {
    
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
extension ObservableArrayAbstract {
    func notifyReload() {
        callbacks.forEach {
            $0.reload()
        }
    }
    
    func notifyAdd(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.addSections(at: indexSet)
        }
    }
    
    func notifyInsert(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.insertSections(at: indexSet)
        }
    }
    
    func notifyUpdate(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.updateSections(at: indexSet)
        }
    }
    
    func notifyRemove(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.removeSections(at: indexSet)
        }
    }
    
    func notifyHeader(section: Int) {
        callbacks.forEach {
            $0.changeHeader(section: section)
        }
    }
    
    func notifyFooter(section: Int) {
        callbacks.forEach {
            $0.changeFooter(section: section)
        }
    }
    
    func notifyAddRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.addCells(at: indexPaths)
        }
    }
    
    func notifyInsertRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.insertCells(at: indexPaths)
        }
    }
    
    func notifyUpdateRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.updateCells(at: indexPaths)
        }
    }
    
    func notifyRemoveRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.removeCells(at: indexPaths)
        }
    }
}
