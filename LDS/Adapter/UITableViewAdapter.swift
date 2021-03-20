//
//  UITableViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

public class UITableViewAdapter<Header, Row : Hashable, Footer>: NSObject, UITableViewDataSource {
    
    public typealias OA = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRowAction = ((UITableView, IndexPath) -> UITableViewCell)
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
        return action(tableView, indexPath)
    }
}

extension UITableViewAdapter: ObservableDataSourceDelegate {
    public func addSection() {
        let indexLastSection: Int = observable.array.count - 1
        tableView.insertSections(.init(integer: indexLastSection), with: .automatic)
    }
    
    public func insertSection(at index: Int) {
        tableView.insertSections(.init(integer: index), with: .automatic)
    }
    
    public func updateSection(at index: Int) {
        tableView.reloadSections(.init(integer: index), with: .automatic)
    }
    
    public func removeSection(at index: Int) {
        tableView.deleteSections(.init(integer: index), with: .automatic)
    }
    
    public func clear() {
        tableView.reloadData()
    }
    
    public func changeHeader(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func changeFooter(section: Int) {
        tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func addCell(section: Int) {
        let indexLasrRow = self.observable.array[section].rows.count - 1
        self.tableView.insertRows(at: [.init(row: indexLasrRow, section: section)], with: .automatic)
        self.tableView.refreshControl?.endRefreshing()
    }
    
    public func insertCell(section: Int, at index: Int) {
        self.tableView.insertRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func updateCell(section: Int, at index: Int) {
        self.tableView.reloadRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func removeCell(section: Int, at index: Int) {
        self.tableView.deleteRows(at: [.init(row: index, section: section)], with: .automatic)
    }
    
    public func clearCells(section: Int, count: Int) {
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i, section: section))
        }
        self.tableView.deleteRows(at: indexPaths, with: .fade)
    }
}
