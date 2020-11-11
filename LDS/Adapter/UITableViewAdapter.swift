//
//  UITableViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

public class UITableViewAdapter<Header, Row, Footer>: NSObject, UITableViewDataSource {
    
    public typealias OA = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRow = ((UITableView, IndexPath) -> UITableViewCell)
    public typealias ViewForSection = ((UITableView, Int) -> String?)
    
    // TODO: need check on leeks
    private let observable: OA
    private let tableView: UITableView
    
    public var cellForRow: CellForRow? = nil
    public var titleForHeaderSection: ViewForSection? = nil
    public var titleForFooterSection: ViewForSection? = nil
    
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
        return self.titleForHeaderSection?(tableView, section)
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.titleForFooterSection?(tableView, section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let action = self.cellForRow else { return UITableViewCell() }
        return action(tableView, indexPath)
    }
}

extension UITableViewAdapter: ObservableDataSourceDelegate {
    public func addSection(observableArray: ObservableArray) {
        let indexLastSection: Int = observable.array.count - 1
        tableView.insertSections(.init(integer: indexLastSection), with: .automatic)
    }
    
    public func insertSection(observableArray: ObservableArray, at index: Int) {
        tableView.insertSections(.init(integer: index), with: .automatic)
    }
    
    public func updateSection(observableArray: ObservableArray, at index: Int) {
        tableView.reloadSections(.init(integer: index), with: .automatic)
    }
    
    public func removeSection(observableArray: ObservableArray, at index: Int) {
        tableView.deleteSections(.init(integer: index), with: .automatic)
    }
    
    public func clear(observableArray: ObservableArray) {
        tableView.reloadData()
    }
    
    public func changeHeader(observableArray: ObservableArray, section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func changeFooter(observableArray: ObservableArray, section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func addCell(observableArray: ObservableArray, section: Int) {
        let indexLasrRow = self.observable.array[section].rows.count - 1
        self.tableView.insertRows(at: [.init(row: indexLasrRow, section: section)], with: .automatic)
        self.tableView.refreshControl?.endRefreshing()
    }
    
    public func insertCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.tableView.insertRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func updateCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.tableView.reloadRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func removeCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.tableView.deleteRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func clearCells(observableArray: ObservableArray, section: Int, count: Int) {
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i, section: section))
        }
        self.tableView.deleteRows(at: indexPaths, with: .fade)
    }
}
