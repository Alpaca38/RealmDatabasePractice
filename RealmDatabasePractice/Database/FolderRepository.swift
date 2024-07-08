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
}
