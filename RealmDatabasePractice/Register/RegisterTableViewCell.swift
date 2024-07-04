//
//  RegisterTableViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class RegisterTableViewCell: BaseTableViewCell {
    private lazy var customView = {
        let view = UIView()
        view.addSubview(self.titleLabel)
        view.addSubview(self.nextButton)
        view.addSubview(self.contentLabel)
        view.addSubview(self.contentImageView)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        self.contentView.addSubview(view)
        return view
    }()
    private let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    private let nextButton = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    private let contentLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    private let contentImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func configureLayout() {
        customView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(8)
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
        contentImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(nextButton.snp.leading).offset(-8)
            $0.size.equalTo(40)
        }
    }
    
    func configure(option: RegisterOptions, date: Date?, tag: String?, priority: String?, image: UIImage?) {
        titleLabel.text = option.optionString
        switch option {
        case .deadline:
            contentLabel.text = date?.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).weekday().locale(Locale(identifier: "ko-KR")))
        case .tag:
            contentLabel.text = tag
        case .priority:
            contentLabel.text = priority
        case .image:
            contentImageView.image = image
        }
    }
}
