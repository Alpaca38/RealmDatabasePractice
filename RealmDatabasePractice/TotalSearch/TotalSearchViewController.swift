//
//  TotalSearchViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import UIKit
import SnapKit

final class TotalSearchViewController: BaseViewController {
    private let viewModel = TotalSearchViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        bindData()
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension TotalSearchViewController {
    func bindData() {
        viewModel.outputList.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.outputFlagDelete.bind { [weak self] _ in
            self?.view.makeToast("깃발이 설정 되었습니다.")
        }
        
        viewModel.outputFlagSet.bind { [weak self] _ in
            self?.view.makeToast("깃발이 해제 되었습니다.")
        }
    }
    
    func setSearchController() {
        searchController.searchBar.placeholder = "제목 및 내용을 검색할 수 있습니다."
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension TotalSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.inputUpdateSearchResults.value = searchController.searchBar.text
    }
}

extension TotalSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputList.value.count
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
        let flag = UIContextualAction(style: .normal, title: "깃발") { [weak self] action, view, completion in
            guard let self else { return }
            let data = viewModel.outputList.value[indexPath.row]
            viewModel.inputFlagAction.value = data
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [flag])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] action, view, completion in
            guard let self else { return }
            let data = viewModel.outputList.value[indexPath.row]
            viewModel.inputDelete.value = data
            viewModel.outputList.value.remove(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = viewModel.outputList.value[indexPath.row]
        let vc = DetailViewController()
        vc.viewModel.outputTodo.value = todo
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
