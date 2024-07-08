//
//  CategoryListViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

final class CategoryListViewController: UIViewController {
    private let categoryListView = CategoryListView()
    private let repository = TodoRepository()
    
    var folder: Folder?
    
    override func loadView() {
        categoryListView.delegate = self
        categoryListView.collectionView.delegate = self
        categoryListView.collectionView.dataSource = self
        view = categoryListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserveTodoTable()
        setNavi()
    }
}

private extension CategoryListViewController {
    func setNavi() {
        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItem = calendarButton
    }
    
    @objc func calendarButtonTapped() {
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setObserveTodoTable() {
        repository.setNotificationToken { [weak self] changes in
            guard let collectionView = self?.categoryListView.collectionView else { return }
            switch changes {
            case .initial(_):
                collectionView.reloadData()
            case .update(_, _, _, _):
                collectionView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}

extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryListCollectionViewCell.identifier, for: indexPath) as! CategoryListCollectionViewCell
        guard let data = CategoryList(rawValue: indexPath.row) else { 
            return cell
        }
        cell.folder = folder
        cell.configure(category: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = CategoryList.allCases[indexPath.item]
        switch selectedCategory {
        case .today:
            let vc = ListViewController(category: .today)
            vc.folder = folder
            navigationController?.pushViewController(vc, animated: true)
        case .todo:
            let vc = ListViewController(category: .todo)
            vc.folder = folder
            navigationController?.pushViewController(vc, animated: true)
        case .total:
            let vc = ListViewController(category: .total)
            vc.folder = folder
            navigationController?.pushViewController(vc, animated: true)
        case .flag:
            let vc = ListViewController(category: .flag)
            vc.folder = folder
            navigationController?.pushViewController(vc, animated: true)
        case .complete:
            let vc = ListViewController(category: .complete)
            vc.folder = folder
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CategoryListViewController: CategoryListDelegate {
    func didCreateTodoButtonTapped() {
        let vc = RegisterViewController()
        vc.folder = folder
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true)
    }
}
