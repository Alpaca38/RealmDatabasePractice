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
        view.addSubview(self.contentLabel)
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
    lazy var contentLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
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
            $0.width.equalTo(10)
            $0.height.equalTo(15)
        }
        contentLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(nextButton.snp.leading).offset(-8)
        }
    }
    
    func configure(option: RegisterOptions, date: Date?) {
        titleLabel.text = option.optionString
        switch option {
        case .deadline:
            contentLabel.text = date?.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko-KR")))
        }
    }
}
