//
//  ObservableDataSourceDelegate.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public protocol ObservableDataSourceDelegate: class {
    func addSection()
    func insertSection(at index: Int)
    func updateSection(at index: Int)
    func removeSection(at index: Int)
    func clear()
    
    func changeHeader(section: Int)
    func changeFooter(section: Int)
    
    func addCell(section: Int)
    func insertCell(section: Int, at index: Int)
    func updateCell(section: Int, at index: Int)
    func removeCell(section: Int, at index: Int)
    func clearCells(section: Int, count: Int)
}
