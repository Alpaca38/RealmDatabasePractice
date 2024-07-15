//
//  FolderViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import UIKit
import Toast

final class FolderViewController: UIViewController {
    private let folderView = FolderView()
    private let viewModel = FolderViewModel()
    
    override func loadView() {
        folderView.collectionView.delegate = self
        folderView.collectionView.dataSource = self
        view = folderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
}

private extension FolderViewController {
    @objc func bindData() {
        viewModel.outputFolderList.bind { [weak self] _ in
            guard let self else { return }
            folderView.collectionView.reloadData()
        }
        
        viewModel.outputObserveError.bind { [weak self] error in
            guard let error else { return }
            self?.view.makeToast(error.localizedDescription, duration: 3, position: .center)
        }
    }
}

extension FolderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputFolderList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryListCollectionViewCell.identifier, for: indexPath) as! CategoryListCollectionViewCell
        let folder = viewModel.outputFolderList.value[indexPath.row]
        cell.configure(folder)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let folder = viewModel.outputFolderList.value[indexPath.row]
        let vc = CategoryListViewController()
        vc.viewModel.outputFolder.value = folder
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
