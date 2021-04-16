//
//  UICollectionViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

// TODO: add support header and footer
public class UICollectionViewAdapter<Header, Row : Hashable, Footer>: NSObject, UICollectionViewDataSource {
    
    public typealias OA = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRow = ((UICollectionView, IndexPath, Row) -> UICollectionViewCell)
    public typealias ViewForSection = ((UICollectionView, Int) -> String?)
    
    // TODO: need check on leeks
    private let observable: OA
    private let collectionView: UICollectionView
    
    public var cellForRow: CellForRow? = nil
    public var titleForHeaderSection: ViewForSection? = nil
    public var titleForFooterSection: ViewForSection? = nil
    
    public init(_ collectionView: UICollectionView, observableArray: OA) {
        self.observable = observableArray
        self.collectionView = collectionView
        super.init()
        observableArray.addCallback(self)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = observable.array.count
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = observable.array[section].rows.count
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let action = self.cellForRow else { return UICollectionViewCell() }
        let rowItem = observable.array[indexPath.section].rows[indexPath.row]
        return action(collectionView, indexPath, rowItem)
    }
}

extension UICollectionViewAdapter: ObservableDataSourceDelegate {
    public func reload() {
        collectionView.reloadData()
    }
    
    public func addSections(at indexSet: IndexSet) {
        collectionView.insertSections(indexSet)
    }
    
    public func insertSections(at indexSet: IndexSet) {
        collectionView.insertSections(indexSet)
    }
    
    public func updateSections(at indexSet: IndexSet) {
        collectionView.reloadSections(indexSet)
    }
    
    public func removeSections(at indexSet: IndexSet) {
        collectionView.deleteSections(indexSet)
    }
    
    public func moveSection(_ section: Int, toSection newSection: Int) {
        collectionView.moveSection(section, toSection: newSection)
    }
    
    public func changeHeader(section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    public func changeFooter(section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    public func addCells(at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: indexPaths)
            self.collectionView.refreshControl?.endRefreshing()
            
        }, completion: nil)
    }
    
    public func insertCells(at indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
    }
    
    public func updateCells(at indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
    }
    
    public func removeCells(at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: indexPaths)
        })
    }
    
    public func moveCell(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        collectionView.moveItem(at: indexPath, to: newIndexPath)
    }
}
