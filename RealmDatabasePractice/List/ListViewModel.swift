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

    var inputViewDidLoadTrigger: Observable<(Folder?, CategoryList?)> = Observable((nil, nil))
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] (folder, category) in
            guard let self, let folder, let category else { return }
            outputList.value = repository.fetchFilterAsArray(folder: folder, category: category)
        }
    }
}
