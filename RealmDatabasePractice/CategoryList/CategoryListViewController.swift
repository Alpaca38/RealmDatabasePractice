//
//  CategoryListViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import RealmSwift

final class CategoryListViewController: UIViewController {
    private let categoryListView = CategoryListView()
    private let realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    override func loadView() {
        categoryListView.delegate = self
        categoryListView.collectionView.delegate = self
        categoryListView.collectionView.dataSource = self
        view = categoryListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserveTodoTable()
    }
}

private extension CategoryListViewController {
    func setObserveTodoTable() {
        let results = realm.objects(Todo.self)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
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
        cell.configure(category: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = CategoryList.allCases[indexPath.item]
        switch selectedCategory {
        case .today:
            let vc = ListViewController(category: .today)
            navigationController?.pushViewController(vc, animated: true)
        case .todo:
            let vc = ListViewController(category: .todo)
            navigationController?.pushViewController(vc, animated: true)
        case .total:
            let vc = ListViewController(category: .total)
            navigationController?.pushViewController(vc, animated: true)
        case .flag:
            let vc = ListViewController(category: .flag)
            navigationController?.pushViewController(vc, animated: true)
        case .complete:
            let vc = ListViewController(category: .complete)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension CategoryListViewController: CategoryListDelegate {
    func didCreateTodoButtonTapped() {
        let vc = RegisterViewController()
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true)
    }
}
