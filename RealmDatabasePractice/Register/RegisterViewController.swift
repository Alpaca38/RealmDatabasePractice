//
//  RegisterViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import RealmSwift
import Toast

final class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    var date: Date?
    
    override func loadView() {
        registerView.tableView.delegate = self
        registerView.tableView.dataSource = self
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
    }
    
}

private extension RegisterViewController {
    func setNavi() {
        title = "새로운 할 일"
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        let realm = try! Realm()
        guard let title = registerView.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            self.view.makeToast("제목이 비어있습니다. 제목을 입력해주세요.", duration: 2, position: .center)
            return
        }
        let data = Todo(title: title, content: registerView.contentTextField.text, date: date)
        try! realm.write {
            realm.add(data)
        }
        dismiss(animated: true)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RegisterOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as! RegisterTableViewCell
        guard let option = RegisterOptions(rawValue: indexPath.row) else {
            return cell
        }
        cell.configure(option: option, date: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == RegisterOptions.allCases.firstIndex(of: .deadline) {
            let vc = DateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension RegisterViewController: DatePickerDelegate {
    func didSaveButtonTapped(date: Date) {
        self.date = date
        registerView.tableView.reloadRows(at: [IndexPath(row: RegisterOptions.deadline.rawValue, section: 0)], with: .automatic)
    }
}
