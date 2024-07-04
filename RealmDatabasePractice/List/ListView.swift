//
//  ListView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class ListView: BaseView {
    lazy var searchBar = {
        let view = UISearchBar()
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
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
