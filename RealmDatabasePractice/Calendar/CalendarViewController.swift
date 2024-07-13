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
    private let viewModel = CalendarViewModel()
    
    var folder: Folder?
    
    override func loadView() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = folder
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
        guard let folder else { return 0 }
        return repository.fetchDate(folder: folder, date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let folder else { return }
        viewModel.outputCalendarTodoList.value = repository.fetchDate(folder: folder, date: date)
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
