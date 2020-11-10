//
//  ObservableArray.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

protocol ObservableArray: class {
    func addCallback(_ callback: ObservableDataSourceDelegate)
    func removeCallback(_ callback: ObservableDataSourceDelegate)
}
