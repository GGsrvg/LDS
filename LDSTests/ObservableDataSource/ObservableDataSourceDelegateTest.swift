//
//  ObservableDataSourceDelegateTest.swift
//  LDSTests
//
//  Created by GGsrvg on 22.10.2021.
//

import XCTest
@testable import LDS

class ObservableDataSourceDelegateTest: XCTestCase {
    
    enum Functions: Equatable {
        case reload
        
        case addSections(indexSet: IndexSet)
        case insertSections(indexSet: IndexSet)
        case updateSections(indexSet: IndexSet)
        case removeSections(indexSet: IndexSet)
        case moveSection(section: Int, newSection: Int)
        
        case changeHeader(section: Int)
        case changeFooter(section: Int)
        
        case addCells(indexPaths: [IndexPath])
        case insertCells(indexPaths: [IndexPath])
        case updateCells(indexPaths: [IndexPath])
        case removeCells(indexPaths: [IndexPath])
        case moveCell(indexPath: IndexPath, newIndexPath: IndexPath)
    }
    
    let observableDataSource = ObservableDataSource<SectionItem<Void, String, Void>>()
    
    var function: Functions?
    
    override func setUp() {
        observableDataSource.addCallback(self)
    }
    
    // base
    func testSet() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        ])
        XCTAssertEqual(self.function, .reload)
    }
    
    func testReload() {
        self.observableDataSource.reload()
        XCTAssertEqual(self.function, .reload)
    }

    // change sections
    func testAppendSection() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.appendSection(
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()) // 4
        )
        XCTAssertEqual(self.function, .addSections(indexSet: IndexSet(integer: 4)))
    }

    func testAppendSections() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.appendSections([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 4
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()) // 5
        ])
        XCTAssertEqual(self.function, .addSections(indexSet: IndexSet(arrayLiteral: 4, 5)))
    }

    // insert
    func testInsertSectionSingleAt() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSection(
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            at: 0
        )
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 0)))
    }

    func testInsertSectionSingleAfter() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSection(
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            after: section
        )
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 2)))
    }

    func testInsertSectionSingleBefore() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSection(
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            before: section
        )
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 1)))
    }

    func testInsertSectionsMultiAt() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSections([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        ], at: 2)
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 2, 3)))
    }

    func testInsertSectionsMultiAfter() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSections([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        ], after: section)
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 2, 3)))
    }

    func testInsertSectionsMultiBefore() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.insertSections([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()),
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        ], before: section)
        XCTAssertEqual(self.function, .insertSections(indexSet: IndexSet(arrayLiteral: 1, 2)))
    }

    // replacing
    func testReplaceSectionAtIndex() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.replaceSection(SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), at: 1)
        XCTAssertEqual(self.function, .updateSections(indexSet: IndexSet(arrayLiteral: 1)))
    }

    func testReplaceSectionAtElement() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.replaceSection(SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), at: section)
        XCTAssertEqual(self.function, .updateSections(indexSet: IndexSet(arrayLiteral: 1)))
    }

    // updating
    func testUpdateSection() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.updateSection(section)
        XCTAssertEqual(self.function, .updateSections(indexSet: IndexSet(arrayLiteral: 1)))
    }

    // removing
    func testRemoveSection() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.removeSection([section])
        XCTAssertEqual(self.function, .removeSections(indexSet: IndexSet(arrayLiteral: 1)))
    }

    func testRemoveAllSections() {
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        self.observableDataSource.removeAllSections()
        XCTAssertEqual(self.function, .removeSections(indexSet: IndexSet(arrayLiteral: 0, 1, 2, 3)))
    }
    
    func testHeader() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.header = ()
        XCTAssertEqual(self.function, .changeHeader(section: 1))
    }
    
    func testFooter() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.footer = ()
        XCTAssertEqual(self.function, .changeFooter(section: 1))
    }

    // append
    func testAppendRow() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRow("")
        XCTAssertEqual(self.function, .addCells(indexPaths: [IndexPath(row: 0, section: 1)]))
    }

    func testAppendRows() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2"])
        XCTAssertEqual(self.function, .addCells(indexPaths: [IndexPath(row: 0, section: 1), IndexPath(row: 1, section: 1)]))
    }

    // insert
    func testInsertRowSingleAt() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["", "", "", "", "", ""])
        section.insertRow("", at: 2)
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 2, section: 1)]))
    }

    func testInsertRowSingleAfter() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.insertRow("r2", after: "t2")
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 2, section: 1)]))
    }

    func testInsertRowSingleBefore() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.insertRow("r2", before: "t2")
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 1, section: 1)]))
    }

    func testInsertRowsMultiAt() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.insertRows(["r2", "r3"], at: 1)
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 1, section: 1), IndexPath(row: 2, section: 1)]))
    }

    func testInsertRowsMultiAfter() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.insertRows(["r2", "r3"], after: "t1")
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 1, section: 1), IndexPath(row: 2, section: 1)]))
    }

    func testInsertRowsMultiBefore() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.insertRows(["r2", "r3"], before: "t2")
        XCTAssertEqual(self.function, .insertCells(indexPaths: [IndexPath(row: 1, section: 1), IndexPath(row: 2, section: 1)]))
    }

    // replacing
    func testReplaceRowAtIndex() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.replaceRow("r2", at: 1)
        XCTAssertEqual(self.function, .updateCells(indexPaths: [IndexPath(row: 1, section: 1)]))
    }

    func testReplaceRowAtElement() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.replaceRow("r2", at: "t2")
        XCTAssertEqual(self.function, .updateCells(indexPaths: [IndexPath(row: 1, section: 1)]))
    }

    // removing
    func testRemoveRow() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.removeRows(["t2", "t3"])
        XCTAssertEqual(self.function, .removeCells(indexPaths: [IndexPath(row: 1, section: 1), IndexPath(row: 2, section: 1)]))
    }

    func testRremoveAllRows() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 0
            section, // 1
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 2
            SectionItem<Void, String, Void>(header: (), rows: [], footer: ()), // 3
        ])
        section.appendRows(["t1", "t2", "t3", "t4", "t5", "t6"])
        section.removeAllRows()
        XCTAssertEqual(self.function, .removeCells(indexPaths: [
            IndexPath(row: 0, section: 1),
            IndexPath(row: 1, section: 1),
            IndexPath(row: 2, section: 1),
            IndexPath(row: 3, section: 1),
            IndexPath(row: 4, section: 1),
            IndexPath(row: 5, section: 1),
        ]))
    }
}

extension ObservableDataSourceDelegateTest: ObservableDataSourceDelegate {
    func reload() {
        self.function = .reload
    }
    
    func addSections(at indexSet: IndexSet) {
        self.function = .addSections(indexSet: indexSet)
    }
    
    func insertSections(at indexSet: IndexSet) {
        self.function = .insertSections(indexSet: indexSet)
    }
    
    func updateSections(at indexSet: IndexSet) {
        self.function = .updateSections(indexSet: indexSet)
    }
    
    func removeSections(at indexSet: IndexSet) {
        self.function = .removeSections(indexSet: indexSet)
    }
    
    func moveSection(_ section: Int, toSection newSection: Int) {
        self.function = .moveSection(section: section, newSection: newSection)
    }
    
    func changeHeader(section: Int) {
        self.function = .changeHeader(section: section)
    }
    
    func changeFooter(section: Int) {
        self.function = .changeFooter(section: section)
    }
    
    func addCells(at indexPaths: [IndexPath]) {
        self.function = .addCells(indexPaths: indexPaths)
    }
    
    func insertCells(at indexPaths: [IndexPath]) {
        self.function = .insertCells(indexPaths: indexPaths)
    }
    
    func updateCells(at indexPaths: [IndexPath]) {
        self.function = .updateCells(indexPaths: indexPaths)
    }
    
    func removeCells(at indexPaths: [IndexPath]) {
        self.function = .removeCells(indexPaths: indexPaths)
    }
    
    func moveCell(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        self.function = .moveCell(indexPath: indexPath, newIndexPath: newIndexPath)
    }
}
