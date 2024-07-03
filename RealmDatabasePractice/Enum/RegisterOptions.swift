//
//  RegisterOptions.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import Foundation

enum RegisterOptions: Int, CaseIterable {
    case deadline
    case tag
    case priority
    case image
    
    var optionString: String {
        switch self {
        case .deadline:
            return "마감일"
        case .tag:
            return "태그"
        case .priority:
            return "우선순위"
        case .image:
            return "이미지 추가"
        }
    }
}
