//
//  FolderRepository.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import Foundation
import RealmSwift

final class FolderRepository {
    private let realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    func createFolder(_ data: Todo, folder: Folder) {
        do {
            try realm.write {
                folder.detail.append(data)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAll() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func printRealmURL() {
        print(realm.configuration.fileURL!)
    }
    
    func observeFolders(completion: @escaping (RealmCollectionChange<Results<Folder>>) -> Void) {
        let results = realm.objects(Folder.self)
        notificationToken = results.observe { changes in
            switch changes {
            case .initial:
                completion(.initial(results))
            case .update(_, _, _, _):
                completion(.update(results, deletions: [], insertions: [], modifications: []))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
