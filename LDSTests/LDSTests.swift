//
//  LDSTests.swift
//  LDSTests
//
//  Created by GGsrvg on 10.11.2020.
//

import XCTest
@testable import LDS

class LDSTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewAdapter() throws {
        let observable = ObservableDataSource<String, String, String>()
        
        let tableView = UITableView()
        let adapter = UITableViewAdapter<String, String, String>(
            tableView,
            observableArray: observable
        )

        tableView.dataSource = adapter
        observableTest(observable)
    }
    
    func testCollectionViewViewAdapter() throws {
        let observable = ObservableDataSource<String, String, String>()
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let adapter = UICollectionViewAdapter<String, String, String>(
            collectionView,
            observableArray: observable
        )
        collectionView.dataSource = adapter
        observableTest(observable)
    }
    
    private func observableTest( _ observable: ObservableDataSource<String, String, String>) {
        observable.addSection(
            .init(
                header: "",
                rows: [],
                footer: ""
            )
        )
        
        observable.insertSection(
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
            at: 0
        )
        
        observable.updateSection(
            .init(
                header: "",
                rows: [],
                footer: ""
            ),
            at: 1
        )
        
        
        observable.removeSection(at: 0)
        
        observable.header("", section: 0)
        observable.footer("", section: 0)
        
        observable.addRow("", section: 0)
        observable.insertRow("", section: 0, at: 0)
        observable.updateRow("", section: 0, at: 0)
        observable.remove(row: "")
        observable.removeRow(section: 0, at: 0)
        observable.clearRow(section: 0)
        observable.clear()
    }
}
