//
//  RegisterOptions.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import Foundation

enum RegisterOptions: Int, CaseIterable {
    case deadline
    
    var optionString: String {
        switch self {
        case .deadline:
            return "마감일"
        }
    }
}
