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

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            guard let self else { return }
            outputList.value = repository.fetchAllAsArray()
        }
    }
}
