//
//  DatePickerDelegate.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import Foundation

protocol DatePickerDelegate: AnyObject {
    func didSaveButtonTapped(date: Date)
}
