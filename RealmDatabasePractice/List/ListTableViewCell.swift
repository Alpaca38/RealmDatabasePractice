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
    
    private lazy var labelStackView = {
        let view = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel, self.dateLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        self.contentView.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
//        titleLabel.snp.makeConstraints {
//            $0.top.horizontalEdges.equalToSuperview().inset(20)
//        }
//        contentLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
//            $0.horizontalEdges.equalToSuperview().inset(20)
//        }
//        dateLabel.snp.makeConstraints {
//            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
//            $0.horizontalEdges.equalToSuperview().inset(20)
//        }
        labelStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    func configure(data: Todo) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        dateLabel.text = data.date?.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko-KR")))
    }
}
