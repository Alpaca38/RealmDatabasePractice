//
//  PriorityViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/9/24.
//

import Foundation

final class PriorityViewModel {
    var outputPriority: Observable<String?> = Observable(nil)
    
    var inputPriority: Observable<String?> = Observable(nil)
    
    init() {
        inputPriority.bind { [weak self] value in
            guard let self else { return }
            outputPriority.value = value
        }
    }
    
}
