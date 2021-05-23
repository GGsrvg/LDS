//
//  ObservableArray.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

public protocol ObservableArray: AnyObject {
    func addCallback(_ callback: ObservableDataSourceUpdating)
    func removeCallback(_ callback: ObservableDataSourceUpdating)
}
