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
    let tableView = UITableView()
    
    override func setUp() {
        let adapter = UITableViewAdapter<String, String, String>(
            tableView,
            observableArray: observable
        )
        adapter.cellForRowAction = { _, _, _ in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            return cell
        }
        adapter.titleForHeaderSectionAction = { _, _ in
            return "H"
        }
        adapter.titleForFooterSectionAction = { _, _ in
            return "H"
        }
        tableView.dataSource = adapter
        tableView.layoutIfNeeded()
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
