//
//  ListViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/13/24.
//

import Foundation

final class ListViewModel {
    private let repository = TodoRepository()
    var outputList: Observable<[Todo]> = Observable([])
    var outputFlagDelete: Observable<Void?> = Observable(nil)
    var outputFlagSet: Observable<Void?> = Observable(nil)

    var inputViewDidLoadTrigger: Observable<(Folder?, CategoryList?)> = Observable((nil, nil))
    var inputDeadLineSortAction: Observable<(Folder?, CategoryList?)> = Observable((nil, nil))
    var inputTitleSortAction: Observable<(Folder?, CategoryList?)> = Observable((nil, nil))
    var inputUpdateSearchResults: Observable<(Folder?, CategoryList?, String?)> = Observable((nil, nil, nil))
    var inputFlagAction: Observable<Todo?> = Observable(nil)
    var inputDelete: Observable<Todo?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] (folder, category) in
            guard let self, let folder, let category else { return }
            outputList.value = repository.fetchFilterAsArray(folder: folder, category: category)
        }
        
        inputDeadLineSortAction.bind { [weak self] (folder, category) in
            guard let self, let folder, let category else { return }
            outputList.value = repository.fetchSortAsArray(folder: folder, category: category, keyPath: "date")
        }
        
        inputTitleSortAction.bind { [weak self] (folder, category) in
            guard let self, let folder, let category else { return }
            outputList.value = repository.fetchSortAsArray(folder: folder, category: category, keyPath: "title")
        }
        
        inputUpdateSearchResults.bind { [weak self] (folder, category, searchText) in
            guard let self, let folder, let category, let searchText else { return }
            outputList.value = repository.searchItemAsArray(folder: folder, category: category, searchText)
        }
        
        inputFlagAction.bind { [weak self] todo in
            guard let todo, let self else { return }
            repository.updateFlagged(data: todo) {
                self.outputFlagDelete.value = ()
                self.outputFlagSet.value = nil
            } isFlagged: {
                self.outputFlagSet.value = ()
                self.outputFlagDelete.value = nil
            }

        }
        
        inputDelete.bind { [weak self] todo in
            guard let todo, let self else { return }
            repository.deleteItem(data: todo)
        }
    }
}
