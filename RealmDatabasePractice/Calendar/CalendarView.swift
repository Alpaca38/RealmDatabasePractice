//
//  CalendarView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/4/24.
//

import UIKit
import FSCalendar
import SnapKit
final class CalendarView: BaseView {
    lazy var calendar = {
        let view = FSCalendar(frame: .zero)
        view.scope = .month
        view.locale = Locale(identifier: "ko-KR")
        view.appearance.headerDateFormat = "YYYY년 M월"
        self.addSubview(view)
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGestures()
    }
    
    override func configureLayout() {
        calendar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

private extension CalendarView {
    func setGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            if calendar.scope == .month {
                calendar.setScope(.week, animated: true)
            }
        case .down:
            if calendar.scope == .week {
                calendar.setScope(.month, animated: true)
            }
        default:
            break
        }
    }
}
