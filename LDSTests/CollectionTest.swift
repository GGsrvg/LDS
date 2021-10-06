//
//  CollectionTest.swift
//  LDSTests
//
//  Created by GGsrvg on 28.03.2021.
//

import XCTest
@testable import LDS

class CollectionTest: XCTestCase {
    
    let observable = ObservableArrayTwoDimension<String, String, String>()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let adapter = UICollectionViewAdapter<String, String, String>(
            collectionView
        )
        adapter.cellForRowHandler = { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.accessibilityLabel = model
            return cell
        }
        adapter.observableDataSource = observable
        collectionView.dataSource = adapter
        collectionView.layoutIfNeeded()
    }
    
    func testAdapter() throws {
        observable.set([
            .init(
                header: "",
                rows: ["", ""],
                footer: ""
            ),
            .init(
                header: "",
                rows: ["", ""],
                footer: ""
            ),
        ])
        
        observable.addSections([
            .init(
                header: "",
                rows: [""],
                footer: ""
            ),
            .init(
                header: "",
                rows: [""],
                footer: ""
            ),
            .init(
                header: "",
                rows: [""],
                footer: ""
            ),
        ])
        
        observable.clear()
        
        observable.addSections([
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
        ])
        
        observable.insertSections([.init(header: "", rows: [""], footer: "")], at: 0)
        
        observable.removeSections(at: .init(integer: 0))
        
        observable.addRows([""], section: 0)
    }
}
