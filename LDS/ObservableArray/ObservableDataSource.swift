//
//  ObservableDataSource.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public class ObservableDataSource<Header, Row, Footer>: ObservableArray where Row : Hashable {
    public typealias SI = SectionItem<Header, Row, Footer>
    
    public private(set) var array: [SI] = []
    private var callbacks: [ObservableDataSourceDelegate] = []
    
    public init(){}
    
    public func addCallback(_ callback: ObservableDataSourceDelegate) {
        callbacks.append(callback)
    }
    
    public func removeCallback(_ callback: ObservableDataSourceDelegate) {
        if let index = callbacks.firstIndex(where: { $0 === callback }) {
            callbacks.remove(at: index)
        }
    }
}

// work with array
extension ObservableDataSource {
    public func set(_ elements: [SI]) {
        array = elements
        notifyReload()
    }
    
    public func clear() {
        array = []
        notifyReload()
    }
    
    public func addSections(_ elements: [SI]) {
        let beforeCount = array.count
        array += elements
        let afterCout = array.count
        
        let indexSet = IndexSet(integersIn: beforeCount..<afterCout)
        notifyAdd(at: indexSet)
    }
    
    public func insertSections(_ elements: [SI], at index: Int) {
        array.insert(contentsOf: elements, at: index)
        let indexSet = IndexSet(integersIn: index..<elements.count)
        notifyInsert(at: indexSet)
    }
    
    public func updateSection(_ element: SI, at index: Int) {
        array[index] = element
        notifyUpdate(at: IndexSet(integer: index))
    }
    
    public func removeSections(at indexSet: IndexSet) {
        array.remove(at: indexSet)
        notifyRemove(at: indexSet)
    }
    
    public func header(_ header: Header, section: Int) {
        array[section].header = header
        notifyHeader(section: section)
    }
    
    public func footer(_ footer: Footer, section: Int) {
        array[section].footer = footer
        notifyFooter(section: section)
    }
    
    public func addRows(_ elements: [Row], section: Int) {
        array[section].rows += elements
        notifyAddRow(at: [
            .init(
                row: array[section].rows.count,
                section: section
            )
        ])
    }
    
    public func insertRow(_ elements: [Row], section: Int, at index: Int) {
        array[section].rows.insert(contentsOf: elements, at: index)
        notifyInsertRow(at: [
            .init(row: index, section: section)
        ])
    }
    
    public func updateRow(_ element: Row, section: Int, at index: Int) {
        array[section].rows[index] = element
        notifyUpdateRow(at: [
            .init(row: index, section: section)
        ])
    }
    
    public func removeRow(section: Int, at index: Int) {
        array[section].rows.remove(at: index)
        notifyRemoveRow(at: [
            .init(row: index, section: section)
        ])
    }
}

// work with callbacks
extension ObservableDataSource {
    
    private func notifyReload() {
        callbacks.forEach {
            $0.reload()
        }
    }
    
    private func notifyAdd(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.addSections(at: indexSet)
        }
    }
    
    private func notifyInsert(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.insertSections(at: indexSet)
        }
    }
    
    private func notifyUpdate(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.updateSections(at: indexSet)
        }
    }
    
    private func notifyRemove(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.removeSections(at: indexSet)
        }
    }
    
    private func notifyHeader(section: Int) {
        callbacks.forEach {
            $0.changeHeader(section: section)
        }
    }
    
    private func notifyFooter(section: Int) {
        callbacks.forEach {
            $0.changeFooter(section: section)
        }
    }
    
    private func notifyAddRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.addCells(at: indexPaths)
        }
    }
    
    private func notifyInsertRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.insertCells(at: indexPaths)
        }
    }
    
    private func notifyUpdateRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.updateCells(at: indexPaths)
        }
    }
    
    private func notifyRemoveRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.removeCells(at: indexPaths)
        }
    }
}

extension ObservableDataSource {
    public func findIndexPath(_ element: Row) -> IndexPath? {
        for (sectionIndex, section) in self.array.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                if row == element {
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
            }
        }
        
        return nil
    }
}
