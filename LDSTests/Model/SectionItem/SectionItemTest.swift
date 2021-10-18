//
//  SectionItemTest.swift
//  LDSTests
//
//  Created by GGsrvg on 17.10.2021.
//

import XCTest
@testable import LDS

class SectionItemTest: XCTestCase {
    
    let section = SectionItem<String?, String, String?>(header: nil, rows: [], footer: nil);

    override func tearDown() {
        self.section.header = nil
        self.section.removeAllRows()
        self.section.footer = nil
    }
    
    // append
    func testAppendRow() {
        self.section.appendRow("Append")
        XCTAssertEqual(self.section.rows, ["Append"])
    }
    
    func testAppendRows() {
        self.section.appendRow("Append")
        XCTAssertEqual(self.section.rows, ["Append"])
    }

    // insert
    func testInsertRowSingleAt() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRow("Insert", at: 1)
        XCTAssertEqual(self.section.rows, ["Test1", "Insert", "Test2"])
    }

    func testInsertRowSingleAfter() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRow("Insert", after: "Test1")
        XCTAssertEqual(self.section.rows, ["Test1", "Insert", "Test2"])
    }

    func testInsertRowSingleBefore() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRow("Insert", before: "Test1")
        XCTAssertEqual(self.section.rows, ["Insert", "Test1", "Test2"])
    }

    func testInsertRowsMultiAt() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRows(["Insert1", "Insert2"], at: 1)
        XCTAssertEqual(self.section.rows, ["Test1", "Insert1", "Insert2", "Test2"])
    }
    
    func testInsertRowsMultiAfter() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRows(["Insert1", "Insert2"], after: "Test2")
        XCTAssertEqual(self.section.rows, ["Test1", "Test2", "Insert1", "Insert2"])
    }
    
    func testInsertRowsMultiBefore() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.insertRows(["Insert1", "Insert2"], before: "Test1")
        XCTAssertEqual(self.section.rows, ["Insert1", "Insert2", "Test1", "Test2"])
    }

    // replacing
    func testReplaceRowAtIndex() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.replaceRow("Replace", at: 1)
        XCTAssertEqual(self.section.rows, ["Test1", "Replace"])
    }

    func testReplaceRowAtElement() {
        self.section.appendRows(["Test1", "Test2"])
        self.section.replaceRow("Replace", at: "Test2")
        XCTAssertEqual(self.section.rows, ["Test1", "Replace"])
    }

    // removing
    func testRemoveRow() {
        self.section.appendRows(["Test1", "Test2", "Test3"])
        self.section.removeRow(["Test2", "Test1"])
        XCTAssertEqual(self.section.rows, ["Test3"])
    }

    func testRremoveAllRows() {
        self.section.appendRows(["Test1", "Test2", "Test3"])
        self.section.removeAllRows()
        XCTAssertEqual(self.section.rows, [])
    }
}
