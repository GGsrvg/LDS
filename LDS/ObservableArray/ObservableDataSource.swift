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
}

// work with array
extension ObservableDataSource {
    public func addSection(_ element: SI) {
        array.append(element)
        notifyAdd()
    }
    
    public func insertSection(_ element: SI, at index: Int) {
        array.insert(element, at: index)
        notifyInsert(at: index)
    }
    
    public func updateSection(_ element: SI, at index: Int) {
        array[index] = element
        notifyUpdate(at: index)
    }
    
    public func removeSection(at index: Int) {
        array.remove(at: index)
        notifyRemove(at: index)
    }
    
    public func clear() {
        array = []
        notifyClear()
    }
    
    public func header(_ header: Header, section: Int) {
        array[section].header = header
        notifyHeader(section: section)
    }
    
    public func footer(_ footer: Footer, section: Int) {
        array[section].footer = footer
        notifyFooter(section: section)
    }
    
    public func addRow(_ element: Row, section: Int) {
        array[section].rows.append(element)
        notifyAddRow(section: section)
    }
    
    public func insertRow(_ element: Row, section: Int, at index: Int) {
        array[section].rows.insert(element, at: index)
        notifyInsertRow(section: section, at: index)
    }
    
    public func updateRow(_ element: Row, section: Int, at index: Int) {
        array[section].rows[index] = element
        notifyUpdateRow(section: section, at: index)
    }
    
    public func remove(row: Row) {
        guard let indexPath = self.findIndexPath(row) else { return }
        self.removeRow(section: indexPath.section, at: indexPath.row)
    }
    
    public func removeRow(section: Int, at index: Int) {
        array[section].rows.remove(at: index)
        notifyRemoveRow(section: section, at: index)
    }
    
    public func clearRow(section: Int) {
        let count = array[section].rows.count
        array[section].rows = []
        notifyClearRow(section: section, count: count)
    }
}

// work with callbacks
extension ObservableDataSource {
    public func addCallback(_ callback: ObservableDataSourceDelegate) {
        callbacks.append(callback)
    }
    
    public func removeCallback(_ callback: ObservableDataSourceDelegate) {
        if let index = callbacks.firstIndex(where: { $0 === callback }) {
            callbacks.remove(at: index)
        }
    }
    
    private func notifyAdd() {
        callbacks.forEach {
            $0.addSection()
        }
    }
    
    private func notifyInsert(at index: Int) {
        callbacks.forEach {
            $0.insertSection(at: index)
        }
    }
    
    private func notifyUpdate(at index: Int) {
        callbacks.forEach {
            $0.updateSection(at: index)
        }
    }
    
    private func notifyClear() {
        callbacks.forEach {
            $0.clear()
        }
    }
    
    private func notifyRemove(at index: Int) {
        callbacks.forEach {
            $0.removeSection(at: index)
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
    
    private func notifyAddRow(section: Int) {
        callbacks.forEach {
            $0.addCell(section: section)
        }
    }
    
    private func notifyInsertRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.insertCell(section: section, at: index)
        }
    }
    
    private func notifyUpdateRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.updateCell(section: section, at: index)
        }
    }
    
    private func notifyRemoveRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.removeCell(section: section, at: index)
        }
    }
    
    private func notifyClearRow(section: Int, count: Int) {
        callbacks.forEach {
            $0.clearCells(section: section, count: count)
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
