//
//  CalendarViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/13/24.
//

import Foundation

final class CalendarViewModel {
    private let repository = TodoRepository()
    var outputCalendarTodoList: Observable<[Todo]> = Observable([])

    var inputViewDidLoadTrigger: Observable<Folder?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { [weak self] folder in
            guard let self, let folder else { return }
            outputCalendarTodoList.value = repository.fetchFilterAsArray(folder: folder, category: .total)
        }
    }
}
