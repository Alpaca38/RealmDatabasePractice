//
//  DetailView.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    private let titleLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    private let contentLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    private let dateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    private let tagLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    private let prioirtyLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    private lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel, self.dateLabel, self.tagLabel, self.prioirtyLabel])
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .leading
        view.distribution = .equalSpacing
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        stackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configure(todo: Todo) {
        titleLabel.text = "제목: \(todo.title)"
        if todo.content!.isEmpty {
            contentLabel.text = "메모: 없음"
        } else {
            contentLabel.text = "메모: \(todo.content!)"
        }
        dateLabel.text = "마감일: \(todo.dateString)"
        tagLabel.text = "태그: \(todo.hashTag ?? "없음")"
        prioirtyLabel.text = "우선순위: \(todo.priority ?? "없음")"
    }
}
