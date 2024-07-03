//
//  ViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: UIViewController {
    let listView = ListView()
    var list: Results<Todo>!
    let realm = try! Realm()
    var notificationToken: NotificationToken?
    
    override func loadView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        view = listView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        setList()
    }
}

private extension ListViewController {
    func setList() {
        let results = realm.objects(Todo.self)
        list = results
        print(realm.configuration.fileURL!)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.listView.tableView else { return }
            switch changes {
            case .initial(_):
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.performBatchUpdates({
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }, completion: { finished in
                    // ...
                })
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func setNavi() {
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        sortButton.menu = {
            let deadlineSort = UIAction(title: "마감일 순으로 보기") { [weak self] _ in
                guard let self else { return }
                let results = realm.objects(Todo.self).sorted(byKeyPath: "date", ascending: true)
                list = results
                listView.tableView.reloadData()
            }
            let titleSort = UIAction(title: "제목 순으로 보기") { [weak self] _ in
                guard let self else { return }
                let results = realm.objects(Todo.self).sorted(byKeyPath: "title", ascending: true)
                list = results
                listView.tableView.reloadData()
            }
            let menu = UIMenu(children: [deadlineSort, titleSort])
            
            return menu
        }()
        navigationItem.rightBarButtonItem = sortButton
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.configure(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completion in
            try! self.realm.write {
                let data = self.list[indexPath.row]
                self.realm.delete(data)
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

