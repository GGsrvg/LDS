//
//  ObservableDataSource.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public class ObservableDataSource<SI: SectionItemPrototype> {
    
    private var callbacks: [ObservableDataSourceDelegate] = []
    
    public private(set) var array: [SI] = []
    
    public init() { }
    
    public func numberOfSections() -> Int {
        return array.count
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        guard section >= 0 && section < self.array.count else {
            return 0
        }
        
        return array[section].rows.count
    }
    
    public func getRow(at indexPath: IndexPath) -> SI.Row? {
        guard indexPath.section >= 0 && indexPath.section < self.array.count else {
            return nil
        }
        
        guard indexPath.row >= 0 && indexPath.row < self.array[indexPath.section].rows.count else {
            return nil
        }
        
        return self.array[indexPath.section].rows[indexPath.row]
    }
    
    private func setSectionDelegate(_ elements: [SI]) {
        elements.forEach {
            $0.delegate = self
            $0.observableDataSourceNotify = self
        }
    }
    
    private func removeSectionDelegate(_ elements: [SI]) {
        elements.forEach {
            $0.delegate = nil
            $0.observableDataSourceNotify = nil
        }
    }
}

// work with array
extension ObservableDataSource: ObservableDataSourceChangeContent {
    public typealias Section = SI
    
    public func set(_ elements: [Section]) {
        setSectionDelegate(elements)
        array = elements
        notifyReload()
    }
    
    public func reload() {
        notifyReload()
    }
    
    public func header(_ header: Section.Header, section: Int) {
        array[section].header = header
        notifyHeader(section: section)
    }
    
    public func footer(_ footer: Section.Footer, section: Int) {
        array[section].footer = footer
        notifyFooter(section: section)
    }
    
    public func appendSection(_ section: Section) {
        setSectionDelegate([section])

        let beforeCount = array.count
        array.append(section)
        let afterCout = array.count

        let indexSet = IndexSet(integersIn: beforeCount..<afterCout)
        notifyAdd(at: indexSet)
    }
    
    public func appendSections(_ sections: [Section]) {
        setSectionDelegate(sections)

        let beforeCount = array.count
        array.append(contentsOf: sections)
        let afterCout = array.count

        let indexSet = IndexSet(integersIn: beforeCount..<afterCout)
        notifyAdd(at: indexSet)
    }
    
    public func insertSection(_ newSection: Section, at i: Int) {
        setSectionDelegate([newSection])

        array.insert(newSection, at: i)
        let indexSet = IndexSet(integer: i)
        notifyInsert(at: indexSet)
    }
    
    public func insertSection(_ newSection: Section, after oldSection: Section) {
        guard let index = self.findSection(oldSection)
        else { return }
        
        self.insertSection(newSection, at: index + 1)
    }
    
    public func insertSection(_ newSection: Section, before oldSection: Section) {
        guard let index = self.findSection(oldSection)
        else { return }
        
        self.insertSection(newSection, at: index)
    }
    
    public func insertSections(_ newSections: [Section], at i: Int) {
        setSectionDelegate(newSections)

        array.insert(contentsOf: newSections, at: i)
        let indexSet = IndexSet(integersIn: i..<(newSections.count + i))
        notifyInsert(at: indexSet)
    }
    
    public func insertSections(_ newSections: [Section], after oldSection: Section) {
        guard let index = self.findSection(oldSection)
        else { return }
        
        self.insertSections(newSections, at: index + 1)
    }
    
    public func insertSections(_ newSections: [Section], before oldSection: Section) {
        guard let index = self.findSection(oldSection)
        else { return }
        
        self.insertSections(newSections, at: index)
    }
    
    public func replaceSection(_ newSection: Section, at i: Int) {
        self.array[i] = newSection
        self.notifyUpdate(at: IndexSet(integer: i))
    }
    
    public func replaceSection(_ newSection: Section, at oldSection: Section) {
        guard let index = self.findSection(oldSection)
        else { return }
        
        self.replaceSection(newSection, at: index)
    }
    
    public func updateSection(_ oldSection: Section) {
        self.replaceSection(oldSection, at: oldSection)
    }
    
    public func removeSection(_ sections: [Section]) {
        let removedIndexs: [Int] = self.array
            .enumerated()
            .compactMap {
                guard sections.contains($0.element) else { return nil }
                return $0.offset
            }
        
        self.array.removeAll { sections.contains($0) }
        self.notifyRemove(at: IndexSet(removedIndexs))
    }
    
    public func removeAllSections() {
        removeSectionDelegate(array)
        array.removeAll()
        notifyReload()
    }
}

// sugar
extension ObservableDataSource {
    public func findSection(_ section: SI) -> Int? {
        guard let index = self.array.firstIndex(of: section)
        else { return nil }
        
        return index
    }
    
    public func findRow(_ elementRow: SI.Row) -> IndexPath? {
        for (sectionIndex, section) in self.array.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                if row == elementRow {
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }
}

extension ObservableDataSource: ObservableDataSourceSubscribe {
    public func addCallback(_ callback: ObservableDataSourceDelegate) {
        guard !callbacks.contains(where: { $0 === callback })
        else { return }

        callbacks.append(callback)
    }

    public func removeCallback(_ callback: ObservableDataSourceDelegate) {
        callbacks.removeAll(where: { $0 === callback })
    }
}

// work with updating
extension ObservableDataSource: ObservableDataSourceNotify {
    public func notifyReload() {
        callbacks.forEach {
            $0.reload()
        }
    }
    
    public func notifyAdd(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.addSections(at: indexSet)
        }
    }
    
    public func notifyInsert(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.insertSections(at: indexSet)
        }
    }
    
    public func notifyUpdate(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.updateSections(at: indexSet)
        }
    }
    
    public func notifyRemove(at indexSet: IndexSet) {
        callbacks.forEach {
            $0.removeSections(at: indexSet)
        }
    }
    
    public func notifyHeader(section: Int) {
        callbacks.forEach {
            $0.changeHeader(section: section)
        }
    }
    
    public func notifyFooter(section: Int) {
        callbacks.forEach {
            $0.changeFooter(section: section)
        }
    }
    
    public func notifyAddRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.addCells(at: indexPaths)
        }
    }
    
    public func notifyInsertRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.insertCells(at: indexPaths)
        }
    }
    
    public func notifyUpdateRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.updateCells(at: indexPaths)
        }
    }
    
    public func notifyRemoveRow(at indexPaths: [IndexPath]) {
        callbacks.forEach {
            $0.removeCells(at: indexPaths)
        }
    }
}

extension ObservableDataSource: SectionItemDelegate {
    public func sectionItemIndex<SIP>(_ sectionItem: SIP) -> Int? where SIP : SectionItemPrototype {
        guard let sectionItem = sectionItem as? SI
        else { return nil }
        
        return self.findSection(sectionItem)
    }
}
