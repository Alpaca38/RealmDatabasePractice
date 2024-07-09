//
//  DateViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class DateViewController: BaseViewController {
    private lazy var datePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.locale = Locale(identifier: "ko-KR")
        view.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var dateLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 18)
        self.view.addSubview(view)
        return view
    }()
    
    weak var delegate: DatePickerDelegate?
    private let viewModel = DateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        bindData()
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            let width = UIScreen.main.bounds.width - 40
            $0.size.equalTo(width)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setNavi() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        viewModel.inputDate.value = sender.date
    }
    
    @objc private func saveButtonTapped() {
        delegate?.didSaveButtonTapped(date: viewModel.inputDate.value)
        navigationController?.popViewController(animated: true)
    }
    
    private func bindData() {
        viewModel.outputDateText.bind { [weak self] in
            guard let self else { return }
            dateLabel.text = $0
        }
    }
}
