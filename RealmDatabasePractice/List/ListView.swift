//
//  ListView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class ListView: BaseView {
    lazy var tableView = {
        let view = UITableView()
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
