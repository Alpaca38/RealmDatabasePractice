//
//  CategoryListCollectionViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import SnapKit

final class CategoryListCollectionViewCell: BaseCollectionViewCell {
    private lazy var customView = {
        let view = UIView()
        view.addSubview(self.imageView)
        view.addSubview(self.countLabel)
        view.addSubview(self.titleLabel)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        self.contentView.addSubview(view)
        return view
    }()
    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let countLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    private let titleLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    override func configureLayout() {
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.size.equalTo(30)
        }
        countLabel.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.equalTo(imageView)
        }
    }
    
    func configure(category: CategoryList) {
        imageView.image = category.categoryImage?.withTintColor(category.tintColor, renderingMode: .alwaysOriginal).withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        countLabel.text = String(category.count)
        titleLabel.text = category.categoryTitle
    }
    
}
