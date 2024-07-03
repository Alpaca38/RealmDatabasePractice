//
//  ListTableViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class ListTableViewCell: BaseTableViewCell {
    private let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    private let contentLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    private let dateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    private let tagLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .blue
        return view
    }()
    
    private lazy var labelStackView = {
        let view = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel, horizontalStackView])
        view.axis = .vertical
        view.spacing = 2
        view.alignment = .leading
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var horizontalStackView = {
        let view = UIStackView(arrangedSubviews: [self.dateLabel, self.tagLabel])
        view.axis = .horizontal
        view.alignment = .leading
        self.contentView.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        labelStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    func configure(data: Todo) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        dateLabel.text = data.date?.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko-KR")))
        tagLabel.text = data.hashTag
    }
}
