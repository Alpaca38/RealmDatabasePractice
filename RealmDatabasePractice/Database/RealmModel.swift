//
//  Todo.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import Foundation
import RealmSwift

final class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regDate: Date
    
    @Persisted var detail: List<Todo>
}

final class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var date: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var isFlagged: Bool
    @Persisted var isComplete: Bool
    
    var dateString: String {
        guard let date else {
            return "없음"
        }
        
        return date.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).weekday().locale(Locale(identifier: "ko-KR")))
    }
    
    var hashTag: String? {
        if let tag = tag?.trimmingCharacters(in: .whitespacesAndNewlines), !tag.isEmpty {
            return "#\(tag)"
        } else {
            return nil
        }
    }
    
    var priorityTitle: String {
        guard let priority, let priorityLevel = Priority(rawValue: priority) else { return title }
        switch priorityLevel {
        case .high:
            return "!!! \(title)"
        case .medium:
            return "!! \(title)"
        case .low:
            return "! \(title)"
        }
    }
    
    convenience init(title: String, content: String?, date: Date?, tag: String?, priority: String?) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.tag = tag
        self.priority = priority
        self.isFlagged = false
        self.isComplete = false
    }
}
