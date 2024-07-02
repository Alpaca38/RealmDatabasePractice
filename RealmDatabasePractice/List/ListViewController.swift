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
        let results = realm.objects(Todo.self)
        list = results
        print(realm.configuration.fileURL!)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.listView.tableView else { return }
            switch changes {
            case .initial(let collectionType):
                tableView.reloadData()
            case .update(let collectionType, let deletions, let insertions, let modifications):
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
    
    private func setNavi() {
        let registerButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(registerButtonTapped))
        navigationItem.leftBarButtonItem = registerButton
    }
    
    @objc private func registerButtonTapped() {
        let vc = RegisterViewController()
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true)
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

