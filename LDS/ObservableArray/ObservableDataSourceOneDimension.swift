//
//  ObservableDataSourceOneDimension.swift
//  LDS
//
//  Created by GGsrvg on 19.05.2021.
//

import Foundation

public class ObservableDataSourceOneDimension<Row>: ObservableDataSourceAbstract<Row> where Row : Hashable {
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
extension ObservableDataSourceOneDimension {
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

    public func updateRow(_ element: Row, at row: Int) {
        array[row] = element
        notifyUpdateRow(at: [
            IndexPath(row: row, section: sectionIndex)
        ])
    }

    public func removeRow(at row: Int) {
        array.remove(at: row)
        notifyRemoveRow(at: [
            IndexPath(row: row, section: sectionIndex)
        ])
    }
}
