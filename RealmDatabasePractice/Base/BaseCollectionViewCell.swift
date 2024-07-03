//
//  BaseCollectionViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    func configureLayout() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
