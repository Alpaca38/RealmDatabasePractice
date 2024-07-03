//
//  RegisterViw.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class RegisterView: BaseView {
    lazy var titleTextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "제목"
        self.addSubview(view)
        return view
    }()
    lazy var contentTextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "메모"
        self.addSubview(view)
        return view
    }()
    lazy var tableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        view.separatorStyle = .none
        view.register(RegisterTableViewCell.self, forCellReuseIdentifier: RegisterTableViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        contentTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(titleTextField)
            $0.height.equalTo(100)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(contentTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
