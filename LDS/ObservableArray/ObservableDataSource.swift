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
        guard !callbacks.contains(where: { $0 === callback })
        else { return }
        
        callbacks.append(callback)
    }
    
    public func removeCallback(_ callback: ObservableDataSourceDelegate) {
        callbacks.removeAll(where: { $0 === callback })
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
        let indexSet = IndexSet(integersIn: index..<(elements.count + index))
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
                row: array[section].rows.count - 1,
                section: section
            )
        ])
    }
    
    public func insertRows(_ elements: [Row], indexPath: IndexPath) {
        array[indexPath.section].rows.insert(contentsOf: elements, at: indexPath.row)
        notifyInsertRow(at: [
            indexPath
        ])
    }
    
    public func updateRow(_ element: Row, indexPath: IndexPath) {
        array[indexPath.section].rows[indexPath.row] = element
        notifyUpdateRow(at: [
            indexPath
        ])
    }
    
    public func removeRow(indexPath: IndexPath) {
        array[indexPath.section].rows.remove(at: indexPath.row)
        notifyRemoveRow(at: [
            indexPath
        ])
    }
    
//    public func moveRow(from: IndexPath, to: IndexPath) {
//        guard let row = getRow(at: from) else { return }
//        array[from.section].rows.remove(at: indexPath.row)
//        self.removeRow(indexPath: from)
//        self.insertRows([row], indexPath: to)
//    }
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
    
//    private func notifyMoveCell(at indexPath: IndexPath, to newIndexPath: IndexPath) {
//        callbacks.forEach {
//            $0.moveCell(at: indexPath, to: newIndexPath)
//        }
//    }
}

// sugar
extension ObservableDataSource {
    public func findRow(_ element: Row) -> IndexPath? {
        for (sectionIndex, section) in self.array.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                if row == element {
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }
    
    public func getRow(at indexPath: IndexPath) -> Row? {
        guard indexPath.section >= 0 && indexPath.section < self.array.count else {
            return nil
        }
        
        guard indexPath.row >= 0 && indexPath.row < self.array[indexPath.section].rows.count else {
            return nil
        }
        
        return self.array[indexPath.section].rows[indexPath.row]
    }
    
    @discardableResult
    public func updateRow(_ row: Row) -> Bool {
        guard let indexPath = findRow(row) else { return false }
        
        self.updateRow(row, indexPath: indexPath)
        return true
    }
    
    public func moveRow(from: IndexPath, to: IndexPath) {
        // TODO: need use moveRow
        guard let row = getRow(at: from) else { return }
        self.removeRow(indexPath: from)
        self.insertRows([row], indexPath: to)
    }
    
//    public func swapAt(_ first: IndexPath, _ second: IndexPath) {
//        let firstRow = self.getRow(at: first)
//        let secondRow = self.getRow(at: second)
//        
//        self.removeRow(indexPath: first)
//        self.insertRows([], indexPath: <#T##IndexPath#>)
//    }z
}
