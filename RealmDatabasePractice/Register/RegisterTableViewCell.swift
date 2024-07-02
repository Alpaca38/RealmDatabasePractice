//
//  RegisterTableViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

class RegisterTableViewCell: BaseTableViewCell {
    lazy var customView = {
        let view = UIView()
        view.addSubview(self.titleLabel)
        view.addSubview(self.nextButton)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        self.contentView.addSubview(view)
        return view
    }()
    lazy var titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    lazy var nextButton = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    
    override func configureLayout() {
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(titleLabel)
            $0.height.equalTo(15)
        }
    }
    
    func configure(data: String) {
        titleLabel.text = data
    }
}
