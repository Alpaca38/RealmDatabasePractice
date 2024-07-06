//
//  ListTableViewCell.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class ListTableViewCell: BaseTableViewCell {
    private let repository = TodoRepository()
    var didCompleteButtonTapped: (() -> Void)?
    var data: Todo?
    
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
    
    private lazy var completeButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var horiziontalStackView = {
        let view = UIStackView(arrangedSubviews: [self.completeButton, self.labelStackView])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .leading
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var labelStackView = {
        let view = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel, horizontalLabelStackView])
        view.axis = .vertical
        view.spacing = 2
        view.alignment = .leading
        return view
    }()
    
    private lazy var horizontalLabelStackView = {
        let view = UIStackView(arrangedSubviews: [self.dateLabel, self.tagLabel])
        view.axis = .horizontal
        view.alignment = .leading
        return view
    }()
    
    override func configureLayout() {
        horiziontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    func configure(data: Todo) {
        titleLabel.text = data.priorityTitle
        contentLabel.text = data.content
        dateLabel.text = data.date?.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko-KR")))
        tagLabel.text = data.hashTag
        var image: UIImage?
        if data.isComplete {
            image = UIImage(systemName: "circle.fill")
        } else {
            image = UIImage(systemName: "circle")
        }
        completeButton.setImage(image, for: .normal)
    }
}

private extension ListTableViewCell {
    @objc func completeButtonTapped() {
        guard let data else { return }
        var image: UIImage?
        repository.updateCompleted(data: data) {
            image = UIImage(systemName: "circle")
        } isCompleted: {
            image = UIImage(systemName: "circle.fill")
        }
        completeButton.setImage(image, for: .normal)
        didCompleteButtonTapped?()
    }
}
