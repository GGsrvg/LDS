//
//  ObservableDataSourceChangeContentTest.swift
//  LDSTests
//
//  Created by GGsrvg on 18.10.2021.
//

import XCTest
@testable import LDS

class ObservableDataSourceChangeContentTest: XCTestCase {
    
    let observableDataSource = ObservableDataSource<SectionItem<Void, String, Void>>()

    override func tearDown() {
    }
    
    // base
    func testSet() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            section
        ])
        XCTAssertEqual(self.observableDataSource.array, [section])
        XCTAssertNotEqual(self.observableDataSource.array, [section, section])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }
    
    func testReload() {
        let section = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        self.observableDataSource.set([
            section
        ])
        self.observableDataSource.reload()
        XCTAssertEqual(self.observableDataSource.array, [section])
        XCTAssertNotEqual(self.observableDataSource.array, [section, section])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }
    
    // change sections
    func testAppendSection() {
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.appendSection(firstSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection])
        self.observableDataSource.appendSection(secondSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testAppendSections() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.appendSections([firstSection, secondSection])
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
        
    }

    // insert
    func testInsertSectionSingleAt() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.appendSection(secondSection)
        self.observableDataSource.insertSection(firstSection, at: 0)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testInsertSectionSingleAfter() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.appendSection(secondSection)
        self.observableDataSource.insertSection(firstSection, after: secondSection)
        XCTAssertEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testInsertSectionSingleBefore() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.appendSection(secondSection)
        self.observableDataSource.insertSection(firstSection, before: secondSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testInsertSectionsMultiAt() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([thirdSection])
        self.observableDataSource.insertSections([firstSection, secondSection], at: 0)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testInsertSectionsMultiAfter() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([firstSection])
        self.observableDataSource.insertSections([secondSection, thirdSection], after: firstSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
        
    }

    func testInsertSectionsMultiBefore() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([thirdSection])
        self.observableDataSource.insertSections([firstSection, secondSection], before: thirdSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    // replacing
    func testReplaceSectionAtIndex() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([firstSection, thirdSection])
        self.observableDataSource.replaceSection(secondSection, at: 1)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testReplaceSectionAtElement() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([firstSection, thirdSection])
        self.observableDataSource.replaceSection(secondSection, at: thirdSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    // updating
    func testUpdateSection() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        self.observableDataSource.set([firstSection, secondSection])
        self.observableDataSource.updateSection(secondSection)
        XCTAssertEqual(self.observableDataSource.array, [firstSection, secondSection])
        XCTAssertNotEqual(self.observableDataSource.array, [secondSection, firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    // removing
    func testRemoveSection() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([firstSection, secondSection, thirdSection])
        self.observableDataSource.removeSection([secondSection, thirdSection])
        XCTAssertEqual(self.observableDataSource.array, [firstSection])
        XCTAssertNotEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
        XCTAssertNotEqual(self.observableDataSource.array, [])
    }

    func testRemoveAllSections() {
        XCTAssertEqual(self.observableDataSource.array, [])
        let firstSection = SectionItem<Void, String, Void>(header: (), rows: [], footer: ())
        let secondSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2"], footer: ())
        let thirdSection = SectionItem<Void, String, Void>(header: (), rows: ["test1", "test2", "test3"], footer: ())
        self.observableDataSource.set([firstSection, secondSection, thirdSection])
        self.observableDataSource.removeAllSections()
        XCTAssertEqual(self.observableDataSource.array, [])
        XCTAssertNotEqual(self.observableDataSource.array, [firstSection, secondSection, thirdSection])
    }
}
