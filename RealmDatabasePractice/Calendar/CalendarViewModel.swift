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
    var outputNumberOfEventsFor: Observable<Int> =  Observable(0)
    
    var inputFolder: Observable<Folder?> = Observable(nil)
    var inputNumberOfEventsFor: Observable<(Folder?, Date?)> =  Observable((nil, nil))
    var inputDidSelect: Observable<(Folder?, Date?)> = Observable((nil, nil))
    
    init() {
        inputFolder.bind { [weak self] folder in
            guard let self, let folder else { return }
            outputCalendarTodoList.value = repository.fetchFilterAsArray(folder: folder, category: .total)
        }
        
        inputNumberOfEventsFor.bind { [weak self] (folder, date) in
            guard let folder, let date, let self else { return }
            outputNumberOfEventsFor.value = repository.fetchDate(folder: folder, date: date).count
        }
        
        inputDidSelect.bind { [weak self] (folder, date) in
            guard let folder, let date, let self else { return }
            outputCalendarTodoList.value = repository.fetchDate(folder: folder, date: date)
        }
        
    }
}
