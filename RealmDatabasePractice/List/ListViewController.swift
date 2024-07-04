//
//  ViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import RealmSwift
import Toast

// DTO
final class ListViewController: UIViewController {
    let repository = TodoRepository()
    var notificationToken: NotificationToken?
    let listView = ListView()
    var category: CategoryList
    var list: Results<Todo>! {
        didSet {
            listView.tableView.reloadData()
        }
    }
    
    init(category: CategoryList) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.searchBar.delegate = self
        view = listView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setList()
        setNavi()
    }
}

private extension ListViewController {
    func setList() {
        let results: Results<Todo>
        results = repository.fetchFilter(category: category)
        list = results
//        print(realm.configuration.fileURL!)
        
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
                list = repository.fetchSort(category: category, keyPath: "date")
                listView.tableView.reloadData()
            }
            let titleSort = UIAction(title: "제목 순으로 보기") { [weak self] _ in
                guard let self else { return }
                list = repository.fetchSort(category: category, keyPath: "title")
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
        cell.didCompleteButtonTapped = { [weak self] in
            guard let self else { return }
            listView.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal, title: "깃발") { action, view, completion in
            let data = self.list[indexPath.row]
            self.repository.updateFlagged(data: data) {
                self.view.makeToast("깃발이 해제 되었습니다.")
            } isFlagged: {
                self.view.makeToast("깃발이 설정 되었습니다.")
            }
        }
        return UISwipeActionsConfiguration(actions: [flag])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completion in
            let data = self.list[indexPath.row]
            self.repository.deleteItem(data: data)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = list[indexPath.row]
        let vc = DetailViewController()
        vc.todo = todo
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let filter = realm.objects(Table.self).where {
//            $0.memoTitle.contains(searchText, options: .caseInsensitive)
//        }
//        let result = searchText.isEmpty ? realm.objects(Table.self) : filter
//        list = result
        list = repository.searchItem(category: category, searchText)
        
    }
}
