//
//  RowItem.swift
//  LDS
//
//  Created by GGsrvg on 30.09.2021.
//

import Foundation

public protocol RowDelegate: AnyObject {
    func reload(_ row: RowItem) -> Bool
}

public class RowItem {
    
    /**
     Return current index path.
     
     If RowItem is not added to the array, nil is returned.
     */
    var indexPath: IndexPath? = nil
    
//    weak var _sectionItem: SectionItemBase?
//    
//    public var sectionItem: SectionItemBase? {
//        get {
//            _sectionItem
//        }
//    }
    
    weak var delegate: RowDelegate?
    
    @discardableResult
    public func reload() -> Bool {
        guard let delegate = delegate else {
            return false
        }

        return delegate.reload(self)
    }
}

extension RowItem: Equatable {
    public static func == (lhs: RowItem, rhs: RowItem) -> Bool {
        return lhs === rhs
    }
}
