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
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            guard let self else { return }
            outputFolderList.value = repository.fetchAll()
        }
    }
}
