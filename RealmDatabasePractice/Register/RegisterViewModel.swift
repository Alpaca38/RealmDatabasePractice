//
//  RegisterViewModel.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/13/24.
//

import Foundation

final class RegisterViewModel {
    var outputTodo: Observable<Todo?> = Observable(Todo(title: "", content: nil, date: nil, tag: nil, priority: nil))
    var outputImage: Observable<NSItemProviderReading?> = Observable(nil)
    
    var inputTitle: Observable<String> = Observable("")
    var inputContent: Observable<String?> = Observable(nil)
    var inputDate: Observable<Date?> = Observable(nil)
    var inputTag: Observable<String?> = Observable(nil)
    var inputPriority: Observable<String?> = Observable(nil)
    var inputImage: Observable<NSItemProviderReading?> = Observable(nil)
    
    init() {
        inputTitle.bind { [weak self] title in
            self?.outputTodo.value?.title = title
        }
        
        inputContent.bind { [weak self] content in
            self?.outputTodo.value?.content = content
        }
        
        inputDate.bind { [weak self] date in
            self?.outputTodo.value?.date = date
        }
        
        inputTag.bind { [weak self] tag in
            self?.outputTodo.value?.tag = tag
        }
        
        inputPriority.bind { [weak self] priority in
            self?.outputTodo.value?.priority = priority
        }
        
        inputImage.bind { [weak self] image in
            self?.outputImage.value = image
        }
    }
}
