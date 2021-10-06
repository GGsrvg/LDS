//
//  ObservableArrayOneDimension.swift
//  LDS
//
//  Created by GGsrvg on 19.05.2021.
//

import Foundation

public class ObservableArrayOneDimension<Row>: ObservableArrayAbstract<Row> where Row : Equatable {
    private let sectionIndex = 0
    
    public private(set) var array: [Row] = []
    
    public override init() { }
    
    public override func numberOfSections() -> Int {
        return 1
    }
    
    public override func numberOfRowsInSection(_ section: Int) -> Int {
        return array.count
    }
    
    public override func getRow(at indexPath: IndexPath) -> Row? {
        guard indexPath.row >= 0 && indexPath.row < self.array.count else {
            return nil
        }
        
        return self.array[indexPath.row]
    }
}

// work with array
extension ObservableArrayOneDimension {
    public func set(_ elements: [Row]) {
        array = elements
        notifyReload()
    }

    public func clear() {
        array = []
        notifyReload()
    }

    public func reload() {
        notifyReload()
    }

    public func addRows(_ elements: [Row]) {
        let beforeArrayCount = array.count
        array += elements
        var addIndexPaths: [IndexPath] = []
        for (index, _) in elements.enumerated() {
            let addIndexPath = IndexPath(row: beforeArrayCount + index,
                                         section: 0)
            addIndexPaths.append(addIndexPath)
        }
        notifyAddRow(at: addIndexPaths)
    }

    public func insertRows(_ elements: [Row], at row: Int) {
        array.insert(contentsOf: elements, at: row)
        var insertIndexPaths: [IndexPath] = []
        for (index, _) in elements.enumerated() {
            let insertIndexPath = IndexPath(row: row + index,
                                            section: 0)
            insertIndexPaths.append(insertIndexPath)
        }
        notifyInsertRow(at: insertIndexPaths)
    }
    
    public func replaceRow(_ element: Row, at row: Int) {
        array[row] = element
        notifyUpdateRow(at: [
            IndexPath(row: row, section: sectionIndex)
        ])
    }
    
    public func updateRows(_ elements: [Row]) {
        let indexPaths: [IndexPath] = self.findRows(elements)
        
        notifyUpdateRow(at: indexPaths)
    }
    
    public func removeRows(_ elements: [Row]) {
        let indexPaths: [IndexPath] = self.findRows(elements)
        
        array.removeAll(where: { elements.contains($0) } )
        notifyRemoveRow(at: indexPaths)
    }
}

// sugar
extension ObservableArrayOneDimension {
    public func findRow(_ elementRow: Row) -> IndexPath? {
        for (rowIndex, row) in self.array.enumerated() {
            if row == elementRow {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
        }
        return nil
    }
    
    public func findRows(_ elements: [Row]) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        
        elements.forEach { element in
            if let indexRow = self.findRow(element) {
                indexPaths.append(indexRow)
            }
        }
        
        return indexPaths
    }
}

// deprecated
extension ObservableArrayOneDimension {
    
    @available(*, deprecated, renamed: "removeRows(at:)")
    public func removeRow(at row: Int) {
        array.remove(at: row)
        notifyRemoveRow(at: [
            IndexPath(row: row, section: sectionIndex)
        ])
    }
    
    @available(*, deprecated, renamed: "updateRows(_:)")
    public func updateRow(_ element: Row, at row: Int) {
        array[row] = element
        notifyUpdateRow(at: [
            IndexPath(row: row, section: sectionIndex)
        ])
    }
    
    @discardableResult
    @available(*, deprecated, renamed: "updateRows(_:)")
    public func updateRow(_ row: Row) -> Bool {
        guard let indexRow = findRow(row) else { return false }

        self.updateRow(row, at: indexRow.row)
        return true
    }
}

