//
//  TableTest.swift
//  LDSTests
//
//  Created by GGsrvg on 28.03.2021.
//

import XCTest
@testable import LDS

class TableTest: XCTestCase {
    
    let observable = ObservableDataSource<String, String, String>()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        let observable = ObservableDataSource<String, String, String>()

        let adapter = UICollectionViewAdapter<String, String, String>(
            collectionView,
            observableArray: observable
        )
        collectionView.dataSource = adapter
        collectionView.layoutIfNeeded()
    }
    
    func testAdapter() throws {
        observable.set([
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
        ])
        
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
        
        observable.addRows([""], section: 0)
    }
}
