//
//  UICollectionViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

class UICollectionViewAdapter<Header, Row, Footer>: NSObject, UICollectionViewDelegate {
    
    typealias OA = ObservableDataSource<Header, Row, Footer>
    typealias CellForRow = ((UITableView, IndexPath) -> UITableViewCell)
    typealias ViewForSection = ((UITableView, Int) -> String?)
    
    // TODO: need check on leeks
    private let observable: OA
    private let collectionView: UICollectionView
    
    public var cellForRow: CellForRow? = nil
    public var titleForHeaderSection: ViewForSection? = nil
    public var titleForFooterSection: ViewForSection? = nil
    
    init(_ collectionView: UICollectionView, observableArray: OA) {
        self.observable = observableArray
        self.collectionView = collectionView
        super.init()
        observableArray.addCallback(self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return observable.array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observable.array[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForHeaderSection?(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.titleForFooterSection?(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let action = self.cellForRow else { return UITableViewCell() }
        return action(tableView, indexPath)
    }
}

extension UICollectionViewAdapter: ObservableDataSourceDelegate {
    func addSection(observableArray: ObservableArray) {
        let indexLastSection: Int = observable.array.count - 1
        collectionView.insertSections(.init(integer: indexLastSection))
    }
    
    func insertSection(observableArray: ObservableArray, at index: Int) {
        collectionView.insertSections(.init(integer: index))
    }
    
    func updateSection(observableArray: ObservableArray, at index: Int) {
        collectionView.reloadSections(.init(integer: index))
    }
    
    func removeSection(observableArray: ObservableArray, at index: Int) {
        collectionView.deleteSections(.init(integer: index))
    }
    
    func clear(observableArray: ObservableArray) {
        collectionView.reloadData()
    }
    
    func changeHeader(observableArray: ObservableArray, section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    func changeFooter(observableArray: ObservableArray, section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    func addCell(observableArray: ObservableArray, section: Int) {
        let indexLasrRow = self.observable.array[section].rows.count - 1
        self.collectionView.insertItems(at: [.init(row: indexLasrRow, section: section)])
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    func insertCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.collectionView.insertItems(at: [.init(row: index, section: section)])
    }
    
    func updateCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.collectionView.insertItems(at: [.init(row: index, section: section)])
    }
    
    func removeCell(observableArray: ObservableArray, section: Int, at index: Int) {
        self.collectionView.insertItems(at: [.init(row: index, section: section)])
    }
    
    func clearCells(observableArray: ObservableArray, section: Int, count: Int) {
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i, section: section))
        }
        self.collectionView.deleteItems(at: indexPaths)
    }
}
