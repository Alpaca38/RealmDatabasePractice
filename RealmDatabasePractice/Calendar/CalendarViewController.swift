//
//  CalendarViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/4/24.
//

import UIKit
import FSCalendar
import RealmSwift
import SnapKit

final class CalendarViewController: UIViewController {
    private let repository = TodoRepository()
    private let calendarView = CalendarView()
    private var list: Results<Todo>! {
        didSet {
            calendarView.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        list = repository.fetchAll()
    }
    override func loadView() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        view = calendarView
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        list = repository.fetchDate(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        calendar.layoutIfNeeded()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.data = data
        cell.configure(data: data)
        return cell
    }
}
