//
//  Todo.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var date: Date?
    @Persisted var tag: String?
    
    var hashTag: String? {
        if let tag = tag {
            return "#\(tag)"
        } else {
            return nil
        }
    }
    
    convenience init(title: String, content: String?, date: Date?, tag: String?) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.tag = tag
    }
}
