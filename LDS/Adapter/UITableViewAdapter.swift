//
//  UITableViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

public class UITableViewAdapter<SI: SectionItemPrototype>: NSObject, UITableViewDataSource {
    
    public typealias ODS = ObservableDataSource<SI>
    
    public typealias CellForRowHandler = ((UITableView, IndexPath, SI.Row) -> UITableViewCell)
    public typealias ViewForSectionHandler = ((UITableView, Int) -> String?)
    /// UITableView is object, Int is number of sections
    public typealias NumberOfSectionsHandler = ((UITableView, Int) -> Void)
    /// UITableView is object, first Int is number of sections, second Int is number of items in section
    public typealias NumberOfItemsInSectionHandler = ((UITableView, Int, Int) -> Void)
    
    public weak var observableDataSource: ODS? { didSet {
        oldValue?.removeCallback(self)
        
        guard let observableDataSource = observableDataSource
        else { return }
        
        observableDataSource.addCallback(self)
    }}
    
    private let tableView: UITableView
    
    private let cellForRowHandler: CellForRowHandler
    private let titleForHeaderSectionHandler: ViewForSectionHandler?
    private let titleForFooterSectionHandler: ViewForSectionHandler?
    private let numberOfSectionsHandler: NumberOfSectionsHandler?
    private let numberOfItemsInSectionHandler: NumberOfItemsInSectionHandler?
    
    public init(
        _ tableView: UITableView,
        cellForRowHandler: @escaping CellForRowHandler,
        titleForHeaderSectionHandler: ViewForSectionHandler?,
        titleForFooterSectionHandler: ViewForSectionHandler?,
        numberOfSectionsHandler: NumberOfSectionsHandler?,
        numberOfItemsInSectionHandler: NumberOfItemsInSectionHandler?
    ) {
        self.tableView = tableView
        self.cellForRowHandler = cellForRowHandler
        self.titleForHeaderSectionHandler = titleForHeaderSectionHandler
        self.titleForFooterSectionHandler = titleForFooterSectionHandler
        self.numberOfSectionsHandler = numberOfSectionsHandler
        self.numberOfItemsInSectionHandler = numberOfItemsInSectionHandler
        super.init()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.numberOfSections()
        self.numberOfSectionsHandler?(tableView, count)
        return count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.numberOfRowsInSection(section)
        self.numberOfItemsInSectionHandler?(tableView, section, count)
        return count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForHeaderSectionHandler?(tableView, section)
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.titleForFooterSectionHandler?(tableView, section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let observableDataSource = observableDataSource,
              let rowItem = observableDataSource.getRow(at: indexPath)
        else { return UITableViewCell() }
        
        return self.cellForRowHandler(tableView, indexPath, rowItem)
    }
}

extension UITableViewAdapter: ObservableDataSourceDelegate {
    public func reload() {
        self.tableView.reloadData()
    }
    
    public func addSections(at indexSet: IndexSet) {
        self.tableView.insertSections(indexSet, with: .automatic)
    }
    
    public func insertSections(at indexSet: IndexSet) {
        self.tableView.insertSections(indexSet, with: .automatic)
    }
    
    public func updateSections(at indexSet: IndexSet) {
        self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    public func removeSections(at indexSet: IndexSet) {
        self.tableView.deleteSections(indexSet, with: .automatic)
    }
    
    public func moveSection(_ section: Int, toSection newSection: Int) {
        self.tableView.moveSection(section, toSection: newSection)
    }
    
    public func changeHeader(section: Int) {
        self.tableView.reloadSections(.init(integer: section), with: .automatic)
    }
    
    public func changeFooter(section: Int) {
        self.tableView.reloadSections(.init(integer: section), with: .automatic)
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
        self.tableView.moveRow(at: indexPath, to: newIndexPath)
    }
}
