//
//  TableTest.swift
//  LDSTests
//
//  Created by GGsrvg on 28.03.2021.
//

import XCTest
@testable import LDS

class TableTest: XCTestCase {
    
    let observable = ObservableArrayTwoDimension<String, String, String>()
    let tableView = UITableView()
    
    override func setUp() {
        let adapter = UITableViewAdapter<String, String, String>(
            tableView
        )
        adapter.observableDataSource = observable
        tableView.dataSource = adapter
        tableView.layoutIfNeeded()
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
