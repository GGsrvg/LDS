//
//  ObservableDataSourceDelegate.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

protocol ObservableDataSourceDelegate: class {
    func addSection(observableArray: ObservableArray)
    func insertSection(observableArray: ObservableArray, at index: Int)
    func updateSection(observableArray: ObservableArray, at index: Int)
    func removeSection(observableArray: ObservableArray, at index: Int)
    func clear(observableArray: ObservableArray)
    
    func changeHeader(observableArray: ObservableArray, section: Int)
    func changeFooter(observableArray: ObservableArray, section: Int)
    
    func addCell(observableArray: ObservableArray, section: Int)
    func insertCell(observableArray: ObservableArray, section: Int, at index: Int)
    func updateCell(observableArray: ObservableArray, section: Int, at index: Int)
    func removeCell(observableArray: ObservableArray, section: Int, at index: Int)
    func clearCells(observableArray: ObservableArray, section: Int, count: Int)
}
