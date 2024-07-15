//
//  FolderViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/13/24.
//

import Foundation

final class FolderViewModel {
    private let repository = FolderRepository()
    var outputFolderList: Observable<[Folder]> = Observable([])
    var outputObserveError: Observable<Error?> = Observable(nil)
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            guard let self else { return }
            outputFolderList.value = repository.fetchAll()
            observeFolders()
        }
    }
    
    private func observeFolders() {
        repository.observeFolders { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .initial(let result):
                outputFolderList.value = Array(result)
            case .update(let result, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                outputFolderList.value = Array(result)
            case .error(let error):
                outputObserveError.value = error
            }
        }
    }
}
