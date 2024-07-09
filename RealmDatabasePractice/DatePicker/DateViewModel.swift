//
//  DateViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/9/24.
//

import Foundation

final class DateViewModel {
    var outputDateText = Observable("")
    
    var inputDate: Observable<Date?> = Observable(nil)
    
    init() {
        inputDate.bind { [weak self] value in
            guard let self, let value else { return }
            outputDateText.value = value.formatted()
        }
    }
    
}
