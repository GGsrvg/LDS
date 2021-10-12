//
//  ObservableArraySubscribe.swift
//  LDS
//
//  Created by GGsrvg on 10.11.2020.
//

import Foundation

/**
 Protocol for subscribe 
 */
public protocol ObservableArraySubscribe: AnyObject {
    func addCallback(_ callback: ObservableArrayDelegate)
    func removeCallback(_ callback: ObservableArrayDelegate)
}
