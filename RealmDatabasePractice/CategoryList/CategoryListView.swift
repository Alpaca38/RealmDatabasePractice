//
//  CategoryListView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import SnapKit

final class CategoryListView: BaseView {
    weak var delegate: CategoryListDelegate?
    private lazy var createToDoButton = {
        let view = UIButton(configuration: UIButton.Configuration.imageTitle(title: "새로운 할 일", subtitle:    nil, image: UIImage(systemName: "plus.circle.fill")))
        view.addTarget(self, action: #selector(createToDoButtonTapped), for: .touchUpInside)
        self.addSubview(view)
        return view
    }()
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.register(CategoryListCollectionViewCell.self, forCellWithReuseIdentifier: CategoryListCollectionViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        createToDoButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(createToDoButton.snp.top)
        }
    }
}

private extension CategoryListView {
    @objc func createToDoButtonTapped() {
        delegate?.didCreateTodoButtonTapped()
    }
    
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
