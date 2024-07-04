//
//  CalendarView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/4/24.
//

import UIKit
import FSCalendar
import SnapKit
class CalendarView: BaseView {
    lazy var calendar = {
        let view = FSCalendar(frame: .zero)
        view.scope = .month
        view.locale = Locale(identifier: "ko-KR")
        view.layoutIfNeeded()
        self.addSubview(view)
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        calendar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
