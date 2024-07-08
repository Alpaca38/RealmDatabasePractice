//
//  FolderView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import UIKit
import SnapKit

final class FolderView: BaseView {
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.register(CategoryListCollectionViewCell.self, forCellWithReuseIdentifier: CategoryListCollectionViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

private extension FolderView {
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 20
        let cellCount: CGFloat = 2
        let width = UIScreen.main.bounds.width - sectionSpacing * 2 - cellSpacing * (cellCount - 1)
        layout.itemSize = CGSize(width: width/cellCount, height: width/cellCount * 0.45)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
}
