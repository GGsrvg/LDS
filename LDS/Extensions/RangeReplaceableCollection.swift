//
//  RangeReplaceableCollection.swift
//  LDS
//
//  Created by GGsrvg on 25.03.2021.
//

import Foundation

// copy from:
// https://stackoverflow.com/questions/26173565/removeobjectsatindexes-for-swift-arrays
extension RangeReplaceableCollection where Self: MutableCollection, Index == Int {

    mutating func remove(at indexes : IndexSet) {
        guard var i = indexes.first, i < count else { return }
        var j = index(after: i)
        var k = indexes.integerGreaterThan(i) ?? endIndex
        while j != endIndex {
            if k != j {
                swapAt(i, j);
                formIndex(after: &i)
            }
            else {
                k = indexes.integerGreaterThan(k) ?? endIndex
            }
            formIndex(after: &j)
        }
        removeSubrange(i...)
    }
    
    func objects(at indexSet: IndexSet) -> [Element] {
        let elements = indexSet.compactMap { i -> Element in
            self[i]
        }
        return elements
    }
}
