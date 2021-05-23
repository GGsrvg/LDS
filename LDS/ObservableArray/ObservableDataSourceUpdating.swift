//
//  ObservableDataSourceUpdating.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public protocol ObservableDataSourceUpdating: AnyObject {
    func reload()
    
    func addSections(at indexSet: IndexSet)
    func insertSections(at indexSet: IndexSet)
    func updateSections(at indexSet: IndexSet)
    func removeSections(at indexSet: IndexSet)
    func  moveSection(_ section: Int, toSection newSection: Int)
    
    func changeHeader(section: Int)
    func changeFooter(section: Int)
    
    func addCells(at indexPaths: [IndexPath])
    func insertCells(at indexPaths: [IndexPath])
    func updateCells(at indexPaths: [IndexPath])
    func removeCells(at indexPaths: [IndexPath])
    func moveCell(at indexPath: IndexPath, to newIndexPath: IndexPath)
}
