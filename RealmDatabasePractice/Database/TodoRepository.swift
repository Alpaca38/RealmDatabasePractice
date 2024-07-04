//
//  TodoRepository.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/4/24.
//

import Foundation
import RealmSwift

final class TodoRepository {
    private let realm = try! Realm()
    
    func createItem(data: Todo) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Todo Create Error")
        }
    }
    
    func updateFlagged(data: Todo, isNotFlagged: @escaping () -> Void, isFlagged: @escaping () -> Void) {
        do {
            try realm.write {
                if data.isFlagged {
                    data.isFlagged = false
                    isNotFlagged()
                } else {
                    data.isFlagged = true
                    isFlagged()
                }
            }
        } catch {
            print("Todo UpdateFlagged Error")
        }
    }
    
    func updateCompleted(data: Todo, isNotCompleted: @escaping () -> Void, isCompleted: @escaping () -> Void) {
        do {
            try realm.write {
                if data.isComplete {
                    data.isComplete = false
                    isNotCompleted()
                } else {
                    data.isComplete = true
                    isCompleted()
                }
            }
        } catch {
            print("Todo UpdateFlagged Error")
        }
    }
    
    func fetchAll() -> Results<Todo> {
        return realm.objects(Todo.self)
    }
    
    func fetchSort(category: CategoryList, keyPath: String) -> Results<Todo> {
        let results = fetchFilter(category: category)
        return results.sorted(byKeyPath: keyPath, ascending: true)
    }
    
    func fetchDate(date: Date) -> Results<Todo> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        return realm.objects(Todo.self).where {
            $0.date >= startOfDay && $0.date < endOfDay
        }
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
            return realm.objects(Todo.self).where {
                $0.isComplete == true
            }
        }
    }
    
    func deleteItem(data: Todo) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Todo Create Error")
        }
    }
    
    func searchItem(category: CategoryList, _ text: String) -> Results<Todo> {
        let results = fetchFilter(category: category)
        let filter = results.where {
            $0.title.contains(text, options: .caseInsensitive) || $0.content.contains(text, options: .caseInsensitive)
        }
        let result = text.isEmpty ? results : filter
        return result
    }
}
