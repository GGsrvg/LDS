//
//  ObservableArray.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public class ObservableArray<SI: SectionItemPrototype> {
    
    private var callbacks: [ObservableArrayDelegate] = []
    
    public private(set) var array: [SI] = []
    
    public init() { }
    
    public func numberOfSections() -> Int {
        return array.count
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        guard section >= 0 && section < self.array.count else {
            return 0
        }
        
        return array[section].rows.count
    }
    
    public func getRow(at indexPath: IndexPath) -> SI.Row? {
        guard indexPath.section >= 0 && indexPath.section < self.array.count else {
            return nil
        }
        
        guard indexPath.row >= 0 && indexPath.row < self.array[indexPath.section].rows.count else {
            return nil
        }
        
        return self.array[indexPath.section].rows[indexPath.row]
    }
    
    private func setSectionDelegate(_ elements: [SI]) {
        elements.forEach {
            $0.delegate = self
            $0.observableArray = self
        }
    }
    
    private func removeSectionDelegate(_ elements: [SI]) {
        elements.forEach {
            $0.delegate = nil
            $0.observableArray = nil
        }
    }
}

// work with array
extension ObservableArray {
    public func set(_ elements: [SI]) {
        setSectionDelegate(elements)
        array = elements
        notifyReload()
    }
    
    public func clear() {
        removeSectionDelegate(array)
        array = []
        notifyReload()
    }
    
    public func reload() {
        notifyReload()
    }
    
    public func addSections(_ elements: [SI]) {
        setSectionDelegate(elements)
        
        let beforeCount = array.count
        array.append(contentsOf: elements)
        let afterCout = array.count
        
        let indexSet = IndexSet(integersIn: beforeCount..<afterCout)
        notifyAdd(at: indexSet)
    }
    
    public func insertSections(_ elements: [SI], at index: Int) {
        setSectionDelegate(elements)
        
        array.insert(contentsOf: elements, at: index)
        let indexSet = IndexSet(integersIn: index..<(elements.count + index))
        notifyInsert(at: indexSet)
    }
    
    public func updateSection(_ element: SI, at index: Int) {
        array[index] = element
        notifyUpdate(at: IndexSet(integer: index))
    }
    
    public func removeSections(at indexSet: IndexSet) {
        removeSectionDelegate(array.objects(at: indexSet))
        array.remove(at: indexSet)
        notifyRemove(at: indexSet)
    }
    
    public func header(_ header: SI.Header, section: Int) {
        array[section].header = header
        notifyHeader(section: section)
    }
    
    public func footer(_ footer: SI.Footer, section: Int) {
        array[section].footer = footer
        notifyFooter(section: section)
    }
    
    public func addRows(_ elements: [SI.Row], section: Int) {
        let indexPath = IndexPath(row: array[section].rows.count, section: section)
//        array[section].rows += elements
        var addIndexPaths: [IndexPath] = []
        for (index, _) in elements.enumerated() {
            var addIndexPath = indexPath
            addIndexPath.row += index
            addIndexPaths.append(addIndexPath)
        }
        notifyAddRow(at: addIndexPaths)
    }
    
    public func insertRows(_ elements: [SI.Row], indexPath: IndexPath) {
//        array[indexPath.section].rows.insert(contentsOf: elements, at: indexPath.row)
//        var insertIndexPaths: [IndexPath] = []
//        for (index, _) in elements.enumerated() {
//            var insertIndexPath = indexPath
//            insertIndexPath.row += index
//            insertIndexPaths.append(insertIndexPath)
//        }
//        notifyInsertRow(at: insertIndexPaths)
    }
    
    public func updateRow(_ element: SI.Row, indexPath: IndexPath) {
//        array[indexPath.section].rows[indexPath.row] = element
//        notifyUpdateRow(at: [
//            indexPath
//        ])
    }
    
    public func removeRow(indexPath: IndexPath) {
//        array[indexPath.section].rows.remove(at: indexPath.row)
//        notifyRemoveRow(at: [
//            indexPath
//        ])
    }
    
    
    public func moveRow(from: IndexPath, to: IndexPath) {
//        guard let row = getRow(at: from) else { return }
//        self.removeRow(indexPath: from)
//        self.insertRows([row], indexPath: to)
        
        
    }
}

// sugar
extension ObservableArray {
    public func findSection(_ elementSection: SI) -> Int? {
        for (sectionIndex, section) in self.array.enumerated() {
            if section == elementSection {
                return sectionIndex
            }
        }
        return nil
    }
    
    public func findRow(_ elementRow: SI.Row) -> IndexPath? {
        for (sectionIndex, section) in self.array.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                if row == elementRow {
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }
    
    @discardableResult
    @available(*, deprecated, message: "Need use RowItem.update()")
    public func updateRow(_ row: SI.Row) -> Bool {
        guard let indexPath = findRow(row) else { return false }
        
        self.updateRow(row, indexPath: indexPath)
        return true
    }
    
}

extension ObservableArray: ObservableArraySubscribe {
    public func addCallback(_ callback: ObservableArrayDelegate) {
        guard !callbacks.contains(where: { $0 === callback })
        else { return }

        callbacks.append(callback)
    }

    public func removeCallback(_ callback: ObservableArrayDelegate) {
        callbacks.removeAll(where: { $0 === callback })
    }
}

// work with updating
extension ObservableArray: ObservableArrayNotify {
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

extension ObservableArray: SectionItemDelegate {
    public func sectionItemIndex<SIP>(_ sectionItem: SIP) -> Int? where SIP : SectionItemPrototype {
        guard let sectionItem = sectionItem as? SI
        else { return nil }
        
        return self.findSection(sectionItem)
    }
}
