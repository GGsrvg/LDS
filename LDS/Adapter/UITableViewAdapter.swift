//
//  UITableViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

public class UITableViewAdapter<Header, Row : Hashable, Footer>: NSObject, UITableViewDataSource {
    
    public typealias OA = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRowAction = ((UITableView, IndexPath, Row) -> UITableViewCell)
    public typealias ViewForSectionAction = ((UITableView, Int) -> String?)
    
    // TODO: need check on leeks
    private let observable: OA
    private let tableView: UITableView
    
    public var cellForRowAction: CellForRowAction? = nil
    public var titleForHeaderSectionAction: ViewForSectionAction? = nil
    public var titleForFooterSectionAction: ViewForSectionAction? = nil
    
    public init(_ tableView: UITableView, observableArray: OA) {
        self.observable = observableArray
        self.tableView = tableView
        super.init()
        observableArray.addCallback(self)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return observable.array.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observable.array[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForHeaderSectionAction?(tableView, section)
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.titleForFooterSectionAction?(tableView, section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let action = self.cellForRowAction else { return UITableViewCell() }
        let rowItem = observable.array[indexPath.section].rows[indexPath.row]
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
    
    public func changeHeader(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func changeFooter(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func addCells(at indexPaths: [IndexPath]) {
//        let indexLasrRow = self.observable.array[section].rows.count - 1
        self.tableView.insertRows(at: indexPaths, with: .automatic)
//        self.tableView.refreshControl?.endRefreshing()
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
}
