//
//  TodoRepository.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/4/24.
//

import Foundation
import RealmSwift

class TodoRepository {
    private let realm = try! Realm()
    
    func createItem(data: Todo) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func updateFlagged(data: Todo, isNotFlagged: @escaping () -> Void, isFlagged: @escaping () -> Void) {
        try! realm.write {
            if data.isFlagged {
                data.isFlagged = false
                isNotFlagged()
            } else {
                data.isFlagged = true
                isFlagged()
            }
        }
    }
    
    func fetchSort(category: CategoryList, keyPath: String) -> Results<Todo> {
        let results = fetchFilter(category: category)
        return results.sorted(byKeyPath: keyPath, ascending: true)
    }
    
    func fetchFilter(category: CategoryList) -> Results<Todo> {
        switch category {
        case .today:
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            return realm.objects(Todo.self).where {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        case .todo:
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            return realm.objects(Todo.self).where {
                $0.date >= today
            }
        case .total:
            return realm.objects(Todo.self)
        case .flag:
            return realm.objects(Todo.self).where {
                $0.isFlagged == true
            }
        case .complete:
            return realm.objects(Todo.self)
        }
    }
    
    func deleteItem(data: Todo) {
        try! realm.write {
            realm.delete(data)
        }
    }
}
