//
//  ObservableDataSourceChangeContent.swift
//  LDS
//
//  Created by GGsrvg on 18.10.2021.
//

import Foundation

public protocol ObservableDataSourceChangeContent: AnyObject {
    associatedtype Section: SectionItemPrototype
    
    // base
    func set(_ elements: [Section])
    
    func reload()
    
    // change header and footer
    func header(_ header: Section.Header, section: Int)
    
    func footer(_ footer: Section.Footer, section: Int)
    
    // change sections
    func appendSection(_ section: Section)
    
    func appendSections(_ sections: [Section])
    
    // insert
    func insertSection(_ newSection: Section, at i: Int)

    func insertSection(_ newSection: Section, after oldSection: Section)

    func insertSection(_ newSection: Section, before oldSection: Section)

    func insertSections(_ newSections: [Section], at i: Int)

    func insertSections(_ newSections: [Section], after oldSection: Section)

    func insertSections(_ newSections: [Section], before oldSection: Section)
    
    // replacing
    func replaceSection(_ newSection: Section, at i: Int)

    func replaceSection(_ newSection: Section, at oldSection: Section)

    // updating
    func updateSection(_ oldSection: Section)

    // removing
    func removeSection(_ sections: [Section])

    func removeAllSections()
}
