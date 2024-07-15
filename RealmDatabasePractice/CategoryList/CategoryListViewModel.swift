//
//  CategoryListViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/15/24.
//

import Foundation
import RealmSwift

final class CategoryListViewModel {
    private let repository = TodoRepository()
    
    var outputList: Observable<CategoryList.AllCases> = Observable([])
    var outputFolder: Observable<Folder?> = Observable(nil)
    var outputObserve: Observable<RealmCollectionChange<Any>?> = Observable(nil)
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.outputList.value = CategoryList.allCases
            self?.setObserveTodoTable()
        }
    }
    private func setObserveTodoTable() {
        repository.setNotificationToken { [weak self] changes in
            self?.outputObserve.value = changes
        }
    }
}
