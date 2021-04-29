//
//  CollectionTest.swift
//  LDSTests
//
//  Created by GGsrvg on 28.03.2021.
//

import XCTest
@testable import LDS

class CollectionTest: XCTestCase {
    
    let observable = ObservableDataSource<String, String, String>()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        let adapter = UICollectionViewAdapter<String, String, String>(
            collectionView
        )
        
        adapter.observableDataSource = observable
        collectionView.layoutIfNeeded()
    }
    
    func testAdapter() throws {
//        observableTest(observable)
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
    }
    
    private func observableTest( _ observable: ObservableDataSource<String, String, String>) {
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
        
//        observable.insertSection(
//            .init(
//                header: "",
//                rows: [],
//                footer: ""
//            ),
//            at: 0
//        )
//
//        observable.updateSection(
//            .init(
//                header: "",
//                rows: [],
//                footer: ""
//            ),
//            at: 1
//        )
//
//
//        observable.removeSection(at: 0)
//
//        observable.header("", section: 0)
//        observable.footer("", section: 0)
//
//        observable.addRow("", section: 0)
//        observable.insertRow("", section: 0, at: 0)
//        observable.updateRow("", section: 0, at: 0)
//        observable.remove(row: "")
//        observable.removeRow(section: 0, at: 0)
//        observable.clearRow(section: 0)
//        observable.clear()
    }
}
