//
//  ReuseIdentifier.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import Foundation

protocol ReuseIdentifier: AnyObject {
    static var identifier: String { get }
}

extension ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: ReuseIdentifier { }
