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
    private let repository = FolderRepository()
    
    override func loadView() {
        folderView.collectionView.delegate = self
        folderView.collectionView.dataSource = self
        view = folderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        observeFolders()
    }
}

private extension FolderViewController {
    @objc func bindData() {
        viewModel.outputFolderList.bind { [weak self] _ in
            guard let self else { return }
            folderView.collectionView.reloadData()
        }
    }
    
    func observeFolders() {
        repository.observeFolders { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .initial(let result):
                viewModel.outputFolderList.value = Array(result)
            case .update(let result, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                viewModel.outputFolderList.value = Array(result)
            case .error(let error):
                view.makeToast(error.localizedDescription, duration: 3, position: .center)
            }
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
        vc.folder = folder
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
