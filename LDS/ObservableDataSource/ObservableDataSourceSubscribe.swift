//
//  ObservableDataSourceSubscribe.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

/**
 Protocol for subscribe 
 */
public protocol ObservableDataSourceSubscribe: AnyObject {
    func addCallback(_ callback: ObservableDataSourceDelegate)
    func removeCallback(_ callback: ObservableDataSourceDelegate)
}
