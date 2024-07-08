//
//  FolderViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import UIKit

final class FolderViewController: UIViewController {
    private let folderView = FolderView()
    private let repository = FolderRepository()
    
    private var list: [Folder] = [] {
        didSet {
            folderView.collectionView.reloadData()
        }
    }
    override func loadView() {
        folderView.collectionView.delegate = self
        folderView.collectionView.dataSource = self
        view = folderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.printRealmURL()
        list = repository.fetchAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folderView.collectionView.reloadData()
    }
}

extension FolderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryListCollectionViewCell.identifier, for: indexPath) as! CategoryListCollectionViewCell
        let folder = list[indexPath.row]
        cell.configure(folder)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let folder = list[indexPath.row]
        let vc = CategoryListViewController()
        vc.folder = folder
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
