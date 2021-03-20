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
    public typealias CellForRow = ((UICollectionView, IndexPath) -> UICollectionViewCell)
    //    public typealias ViewForSection = ((UICollectionView, Int) -> String?)
    
    // TODO: need check on leeks
    private let observable: OA
    private let collectionView: UICollectionView
    
    public var cellForRow: CellForRow? = nil
    //    public var titleForHeaderSection: ViewForSection? = nil
    //    public var titleForFooterSection: ViewForSection? = nil
    
    public init(_ collectionView: UICollectionView, observableArray: OA) {
        self.observable = observableArray
        self.collectionView = collectionView
        super.init()
        observableArray.addCallback(self)
        collectionView.dataSource = self
        collectionView.layoutIfNeeded()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = observable.array.count
        print("Count Section = \(count)")
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = observable.array[section].rows.count
        print("Count Row = \(count) in Section = \(section)")
        return count
    }
    
    //    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return self.titleForHeaderSection?(tableView, section)
    //    }
    //
    //    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return self.titleForFooterSection?(tableView, section)
    //    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let action = self.cellForRow else {
            return UICollectionViewCell()
        }
        return action(collectionView, indexPath)
    }
}

extension UICollectionViewAdapter: ObservableDataSourceDelegate {
    public func addSection() {
        let indexLastSection: Int = observable.array.count - 1
//                var indexPaths = [IndexPath]()
//        
//                for (i, _ ) in observable.array[indexLastSection].rows.enumerated() {
//                    indexPaths.append(.init(item: i, section: indexLastSection))
//                }
        
        //        if indexLastSection == 0 {
        //            collectionView.reloadData()
        //        } else {
        //            collectionView.insertItems(at: indexPaths) //[.init(row: 0, section: indexLastSection)]) //.insertSections(.init(integer: indexLastSection))
        //        collectionView.performBatchUpdates({
        //        collectionView.reloadData()
//                    collectionView.insertItems(at: indexPaths)
        collectionView.insertSections(IndexSet(integer: indexLastSection))
        //        }, completion: nil)
        //        }
    }
    
    public func insertSection(at index: Int) {
        collectionView.insertSections(.init(integer: index))
    }
    
    public func updateSection(at index: Int) {
        collectionView.reloadSections(.init(integer: index))
    }
    
    public func removeSection(at index: Int) {
        collectionView.deleteSections(.init(integer: index))
    }
    
    public func clear() {
        collectionView.reloadData()
    }
    
    public func changeHeader(section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    public func changeFooter(section: Int) {
        collectionView.reloadSections(.init(integer: section))
    }
    
    public func addCell(section: Int) {
        let indexLastRow = self.observable.array[section].rows.count - 1
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [.init(row: indexLastRow, section: section)])
            self.collectionView.refreshControl?.endRefreshing()
            
        }, completion: nil)
    }
    
    public func insertCell(section: Int, at index: Int) {
        self.collectionView.insertItems(at: [.init(row: index, section: section)])
    }
    
    public func updateCell(section: Int, at index: Int) {
        self.collectionView.insertItems(at: [.init(row: index, section: section)])
    }
    
    public func removeCell(section: Int, at index: Int) {
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [.init(row: index, section: section)])
        })
    }
    
    public func clearCells(section: Int, count: Int) {
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i, section: section))
        }
        self.collectionView.deleteItems(at: indexPaths)
    }
}
