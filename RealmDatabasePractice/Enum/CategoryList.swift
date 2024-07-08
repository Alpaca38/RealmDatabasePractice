//
//  CategoryList.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import RealmSwift

enum CategoryList: Int, CaseIterable {
    case today
    case todo
    case total
    case flag
    case complete
    
    var categoryTitle: String {
        switch self {
        case .today:
            return "오늘"
        case .todo:
            return "예정"
        case .total:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .complete:
            return "완료됨"
        }
    }
    
    var categoryImage: UIImage? {
        switch self {
        case .today:
            return UIImage(systemName: "lightbulb.circle.fill")
        case .todo:
            return UIImage(systemName: "calendar.circle.fill")
        case .total:
            return UIImage(systemName: "tray.circle.fill")
        case .flag:
            return UIImage(systemName: "flag.circle.fill")
        case .complete:
            return UIImage(systemName: "checkmark.circle.fill")
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .today:
            return .blue
        case .todo:
            return .red
        case .total:
            return .gray
        case .flag:
            return .orange
        case .complete:
            return .lightGray
        }
    }
    
    func count(in folder: Folder) -> Int {
            let calendar = Calendar.current
            switch self {
            case .today:
                let startOfDay = calendar.startOfDay(for: Date())
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                return folder.detail.where { $0.date >= startOfDay && $0.date < endOfDay }.count
            case .todo:
                let today = calendar.startOfDay(for: Date())
                return folder.detail.where { $0.date >= today }.count
            case .total:
                return folder.detail.count
            case .flag:
                return folder.detail.where { $0.isFlagged == true }.count
            case .complete:
                return folder.detail.where { $0.isComplete == true }.count
            }
        }
}
