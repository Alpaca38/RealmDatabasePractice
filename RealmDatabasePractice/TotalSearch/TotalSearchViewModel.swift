//
//  TotalSearchViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/13/24.
//

import Foundation

final class TotalSearchViewModel {
    private let repository = TodoRepository()
    var outputList: Observable<[Todo]> = Observable([])
    var outputFlagDelete: Observable<Void?> = Observable(nil)
    var outputFlagSet: Observable<Void?> = Observable(nil)

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputUpdateSearchResults: Observable<String?> = Observable(nil)
    var inputFlagAction: Observable<Todo?> = Observable(nil)
    var inputDelete: Observable<Todo?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            guard let self else { return }
            outputList.value = repository.fetchAllAsArray()
        }
        
        inputUpdateSearchResults.bind { [weak self] searchText in
            guard let searchText, let self else { return }
            outputList.value = repository.searchItemAsArray(searchText)
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
