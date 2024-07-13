//
//  ViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import Toast

// DTO
final class ListViewController: UIViewController {
    var folder: Folder?
    private let repository = TodoRepository()
    private let viewModel = ListViewModel()
    private let listView = ListView()
    private var category: CategoryList
    
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        view = listView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = (folder, category)
        setNavi()
        setSearchController()
        bindData()
    }
}

private extension ListViewController {
    func bindData() {
        viewModel.outputList.bind { [weak self] _ in
            self?.listView.tableView.reloadData()
        }
    }
    
    func setSearchController() {
        searchController.searchBar.placeholder = "제목 및 내용을 검색할 수 있습니다."
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setNavi() {
        title = category.categoryTitle
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        sortButton.menu = {
            let deadlineSort = UIAction(title: "마감일 순으로 보기") { [weak self] _ in
                guard let self, let folder else { return }
                viewModel.outputList.value = repository.fetchSortAsArray(folder: folder, category: category, keyPath: "date")
            }
            let titleSort = UIAction(title: "제목 순으로 보기") { [weak self] _ in
                guard let self, let folder else { return }
                viewModel.outputList.value = repository.fetchSortAsArray(folder: folder, category: category, keyPath: "title")
            }
            let menu = UIMenu(children: [deadlineSort, titleSort])
            
            return menu
        }()
        navigationItem.rightBarButtonItem = sortButton
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let folder else { return }
        viewModel.outputList.value = repository.searchItemAsArray(folder: folder, category: category, searchController.searchBar.text!)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let data = viewModel.outputList.value[indexPath.row]
        cell.data = data
        cell.configure(data: data)
        cell.didCompleteButtonTapped = {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal, title: "깃발") { action, view, completion in
            let data = self.viewModel.outputList.value[indexPath.row]
            self.repository.updateFlagged(data: data) {
                self.view.makeToast("깃발이 해제 되었습니다.")
            } isFlagged: {
                self.view.makeToast("깃발이 설정 되었습니다.")
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [flag])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completion in
            let data = self.viewModel.outputList.value[indexPath.row]
            self.repository.deleteItem(data: data)
            self.viewModel.outputList.value.remove(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = viewModel.outputList.value[indexPath.row]
        let vc = DetailViewController()
        vc.todo = todo
        navigationController?.pushViewController(vc, animated: true)
    }
}
