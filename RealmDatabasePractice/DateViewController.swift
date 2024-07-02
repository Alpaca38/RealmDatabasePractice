//
//  DateViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import SnapKit

final class DateViewController: UIViewController {
    lazy var datePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.locale = Locale(identifier: "ko-KR")
        view.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        self.view.addSubview(view)
        return view
    }()
    
    private var date = Date()
    weak var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setNavi()
        configureLayout()
    }
    
    private func configureLayout() {
        datePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            let width = UIScreen.main.bounds.width - 40
            $0.size.equalTo(width)
        }
    }
    
    private func setNavi() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc private func saveButtonTapped() {
        delegate?.didSaveButtonTapped(date: date)
        navigationController?.popViewController(animated: true)
    }
}
