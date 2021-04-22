//
//  UITableViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

public class UITableViewAdapter<Header, Row : Hashable, Footer>: NSObject, UITableViewDataSource {
    
    public typealias ODS = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRowAction = ((UITableView, IndexPath, Row) -> UITableViewCell)
    public typealias ViewForSectionAction = ((UITableView, Int) -> String?)
    
    private let tableView: UITableView
    
    public var cellForRowAction: CellForRowAction? = nil
    public var titleForHeaderSectionAction: ViewForSectionAction? = nil
    public var titleForFooterSectionAction: ViewForSectionAction? = nil
    
    public var observableDataSource: ODS? { willSet {
        guard let observableDataSource = newValue else {
            self.observableDataSource?.removeCallback(self)
            return
        }
        
        observableDataSource.addCallback(self)
    }}
    
    public init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.array.count
        return count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.array[section].rows.count
        return count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForHeaderSectionAction?(tableView, section)
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.titleForFooterSectionAction?(tableView, section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let action = self.cellForRowAction,
              let observableDataSource = observableDataSource
        else { return UITableViewCell() }
        
        let rowItem = observableDataSource.array[indexPath.section].rows[indexPath.row]
        return action(tableView, indexPath, rowItem)
    }
}

extension UITableViewAdapter: ObservableDataSourceDelegate {
    public func reload() {
        tableView.reloadData()
    }
    
    public func addSections(at indexSet: IndexSet) {
        tableView.insertSections(indexSet, with: .automatic)
    }
    
    public func insertSections(at indexSet: IndexSet) {
        tableView.insertSections(indexSet, with: .automatic)
    }
    
    public func updateSections(at indexSet: IndexSet) {
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    public func removeSections(at indexSet: IndexSet) {
        tableView.deleteSections(indexSet, with: .automatic)
    }
    
    public func moveSection(_ section: Int, toSection newSection: Int) {
        tableView.moveSection(section, toSection: newSection)
    }
    
    public func changeHeader(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func changeFooter(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func addCells(at indexPaths: [IndexPath]) {
        self.tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    public func insertCells(at indexPaths: [IndexPath]) {
        self.tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    public func updateCells(at indexPaths: [IndexPath]) {
        self.tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    public func removeCells(at indexPaths: [IndexPath]) {
        self.tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    public func moveCell(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.moveRow(at: indexPath, to: newIndexPath)
    }
}
