//
//  CategoryListViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

final class CategoryListViewController: UIViewController {
    private let categoryListView = CategoryListView()
    let viewModel = CategoryListViewModel()
    
    override func loadView() {
        categoryListView.delegate = self
        categoryListView.collectionView.delegate = self
        categoryListView.collectionView.dataSource = self
        view = categoryListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        bindData()
    }
}

private extension CategoryListViewController {
    func bindData() {
        viewModel.outputObserve.bind { [weak self] changes in
            guard let collectionView = self?.categoryListView.collectionView else { return }
            switch changes {
            case .initial(_):
                collectionView.reloadData()
            case .update(_, _, _, _):
                collectionView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            case .none:
                print("none")
            }
        }
    }
    
    func setNavi() {
        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItem = calendarButton
    }
    
    @objc func calendarButtonTapped() {
        let vc = CalendarViewController()
        vc.viewModel.inputFolder.value = viewModel.outputFolder.value
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryListCollectionViewCell.identifier, for: indexPath) as! CategoryListCollectionViewCell
        guard let data = CategoryList(rawValue: indexPath.row) else { 
            return cell
        }
        cell.folder = viewModel.outputFolder.value
        cell.configure(category: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = CategoryList.allCases[indexPath.item]
        let vc = ListViewController(category: selectedCategory)
        vc.viewModel.inputViewDidLoadTrigger.value = (viewModel.outputFolder.value, selectedCategory)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryListViewController: CategoryListDelegate {
    func didCreateTodoButtonTapped() {
        let vc = RegisterViewController()
        vc.viewModel.outputFolder.value = viewModel.outputFolder.value
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true)
    }
}
