//
//  ObservableDataSource.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

final class ObservableDataSource<Header, Row, Footer>: ObservableArray {
    public typealias SI = SectionItem<Header, Row, Footer>
    
    private(set) var array: [SI] = []
    private var callbacks: [ObservableDataSourceDelegate] = []
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
            $0.addSection(observableArray: self)
        }
    }
    
    private func notifyInsert(at index: Int) {
        callbacks.forEach {
            $0.insertSection(observableArray: self, at: index)
        }
    }
    
    private func notifyUpdate(at index: Int) {
        callbacks.forEach {
            $0.updateSection(observableArray: self, at: index)
        }
    }
    
    private func notifyClear() {
        callbacks.forEach {
            $0.clear(observableArray: self)
        }
    }
    
    private func notifyRemove(at index: Int) {
        callbacks.forEach {
            $0.removeSection(observableArray: self, at: index)
        }
    }
    
    private func notifyHeader(section: Int) {
        callbacks.forEach {
            $0.changeHeader(observableArray: self, section: section)
        }
    }
    
    private func notifyFooter(section: Int) {
        callbacks.forEach {
            $0.changeFooter(observableArray: self, section: section)
        }
    }
    
    private func notifyAddRow(section: Int) {
        callbacks.forEach {
            $0.addCell(observableArray: self, section: section)
        }
    }
    
    private func notifyInsertRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.insertCell(observableArray: self, section: section, at: index)
        }
    }
    
    private func notifyUpdateRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.updateCell(observableArray: self, section: section, at: index)
        }
    }
    
    private func notifyRemoveRow(section: Int, at index: Int) {
        callbacks.forEach {
            $0.removeCell(observableArray: self, section: section, at: index)
        }
    }
    
    private func notifyClearRow(section: Int, count: Int) {
        callbacks.forEach {
            $0.clearCells(observableArray: self, section: section, count: count)
        }
    }
}
