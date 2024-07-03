//
//  PriorityDelegate.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import Foundation

protocol PriorityDelegate: AnyObject {
    func sendPriority(_ priority: String)
}
