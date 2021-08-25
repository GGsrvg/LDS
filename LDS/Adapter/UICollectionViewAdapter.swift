//
//  UICollectionViewAdapter.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import UIKit

// TODO: add support header and footer
public class UICollectionViewAdapter<Header, Row: Equatable, Footer>: NSObject, UICollectionViewDataSource {
    
    public typealias ODS = ObservableDataSourceAbstract<Row>
   
    public typealias CellForRowHandler = ((UICollectionView, IndexPath, Row) -> UICollectionViewCell)
    public typealias ViewForSupplementaryElementOfKindHandler = ((UICollectionView, String, IndexPath) -> UICollectionReusableView)
    /// UICollectionView is object, Int is number of sections
    public typealias NumberOfSectionsHandler = ((UICollectionView, Int) -> Void)
    /// UICollectionView is object, first Int is number of sections, second Int is number of items in section
    public typealias NumberOfItemsInSectionHandler = ((UICollectionView, Int, Int) -> Void)
    
    private let collectionView: UICollectionView
    
    public var cellForRowHandler: CellForRowHandler? = nil
    public var viewForSupplementaryElementOfKindHandler: ViewForSupplementaryElementOfKindHandler? = nil
    public var numberOfSectionsHandler: NumberOfSectionsHandler? = nil
    public var numberOfItemsInSectionHandler: NumberOfItemsInSectionHandler? = nil
    
    public weak var observableDataSource: ODS? { didSet {
        oldValue?.removeCallback(self)
        
        guard let observableDataSource = observableDataSource
        else { return }
        
        observableDataSource.addCallback(self)
    }}
    
    public init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.numberOfSections()
        self.numberOfSectionsHandler?(collectionView, count)
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let observableDataSource = observableDataSource else { return 0 }
        let count = observableDataSource.numberOfRowsInSection(section)
        self.numberOfItemsInSectionHandler?(collectionView, section, count)
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let handler = self.cellForRowHandler,
              let observableDataSource = observableDataSource,
              let rowItem = observableDataSource.getRow(at: indexPath)
        else { return UICollectionViewCell() }
        
        return handler(collectionView, indexPath, rowItem)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let action = self.viewForSupplementaryElementOfKindHandler else { return UICollectionReusableView() }
        return action(collectionView, kind, indexPath)
    }
}

extension UICollectionViewAdapter: ObservableDataSourceUpdating {
    public func reload() {
        self.collectionView.reloadData()
    }
    
    public func addSections(at indexSet: IndexSet) {
//        print(indexSet)
//        self.collectionView.performBatchUpdates({
            self.collectionView.insertSections(indexSet)
//        }, completion: nil)
    }
    
    public func insertSections(at indexSet: IndexSet) {
        self.collectionView.insertSections(indexSet)
    }
    
    public func updateSections(at indexSet: IndexSet) {
        self.collectionView.reloadSections(indexSet)
    }
    
    public func removeSections(at indexSet: IndexSet) {
        self.collectionView.deleteSections(indexSet)
    }
    
    public func moveSection(_ section: Int, toSection newSection: Int) {
        self.collectionView.moveSection(section, toSection: newSection)
    }
    
    public func changeHeader(section: Int) {
        self.collectionView.reloadSections(.init(integer: section))
    }
    
    public func changeFooter(section: Int) {
        self.collectionView.reloadSections(.init(integer: section))
    }
    
    public func addCells(at indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
    }
    
    public func insertCells(at indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
    }
    
    public func updateCells(at indexPaths: [IndexPath]) {
        self.collectionView.reloadItems(at: indexPaths)
    }
    
    public func removeCells(at indexPaths: [IndexPath]) {
        self.collectionView.deleteItems(at: indexPaths)
    }
    
    public func moveCell(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        self.collectionView.moveItem(at: indexPath, to: newIndexPath)
    }
}
