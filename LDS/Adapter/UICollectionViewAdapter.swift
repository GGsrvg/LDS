//
//  UICollectionViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

// TODO: add support header and footer
public class UICollectionViewAdapter<Header, Row : Hashable, Footer>: NSObject, UICollectionViewDataSource {
    
    public typealias ODS = ObservableDataSource<Header, Row, Footer>
    public typealias CellForRow = ((UICollectionView, IndexPath, Row) -> UICollectionViewCell)
    public typealias ViewForSupplementaryElementOfKind = ((UICollectionView, String, IndexPath) -> UICollectionReusableView)
    
    private let collectionView: UICollectionView
    
    public var cellForRow: CellForRow? = nil
    public var viewForSupplementaryElementOfKind: ViewForSupplementaryElementOfKind? = nil
    
    public var observableDataSource: ODS? { willSet {
        guard let observableDataSource = newValue else {
            self.observableDataSource?.removeCallback(self)
            return
        }
        
        observableDataSource.addCallback(self)
    }}
    
    public init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.array.count
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.array[section].rows.count
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let action = self.cellForRow,
              let observableDataSource = observableDataSource
        else { return UICollectionViewCell() }
        
        let rowItem = observableDataSource.array[indexPath.section].rows[indexPath.row]
        return action(collectionView, indexPath, rowItem)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let action = self.viewForSupplementaryElementOfKind else { return UICollectionReusableView() }
        return action(collectionView, kind, indexPath)
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
