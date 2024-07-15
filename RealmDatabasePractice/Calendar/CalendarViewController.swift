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
    private let calendarView = CalendarView()
    let viewModel = CalendarViewModel()
    
    override func loadView() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
}

private extension CalendarViewController {
    func bindData() {
        viewModel.outputCalendarTodoList.bind { [weak self] _ in
            self?.calendarView.tableView.reloadData()
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        viewModel.inputNumberOfEventsFor.value = (viewModel.inputFolder.value, date)
        return viewModel.outputNumberOfEventsFor.value
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.inputDidSelect.value = (viewModel.inputFolder.value, date)
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
        return viewModel.outputCalendarTodoList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let data = viewModel.outputCalendarTodoList.value[indexPath.row]
        cell.data = data
        cell.configure(data: data)
        return cell
    }
}
