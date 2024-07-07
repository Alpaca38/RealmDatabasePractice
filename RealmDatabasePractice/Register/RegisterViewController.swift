//
//  RegisterViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit
import PhotosUI
import Toast

final class RegisterViewController: UIViewController {
    private let registerView = RegisterView()
    private let repository = TodoRepository()
    private var date: Date?
    private var tag: String?
    private var priority: String?
    private var image: UIImage?
    
    override func loadView() {
        registerView.tableView.delegate = self
        registerView.tableView.dataSource = self
        registerView.titleTextField.delegate = self
        registerView.contentTextField.delegate = self
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        guard let title = registerView.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            self.view.makeToast("제목이 비어있습니다. 제목을 입력해주세요.", duration: 2, position: .center)
            return
        }
        let data = Todo(title: title, content: registerView.contentTextField.text, date: date, tag: tag, priority: priority)
        repository.createItem(data: data)
        if let image {
            saveImageToDocument(image: image, filename: "\(data.id)")
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
        cell.configure(option: option, date: date, tag: tag, priority: priority, image: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOptions = RegisterOptions.allCases[indexPath.row]
        switch selectedOptions {
        case .deadline:
            let vc = DateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .tag:
            let vc = TagViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .priority:
            let vc = PriorityViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .image:
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.screenshots, .images])
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
        }
    }
}

extension RegisterViewController: PriorityDelegate {
    func sendPriority(_ priority: String) {
        self.priority = priority
        registerView.tableView.reloadRows(at: [IndexPath(row: RegisterOptions.priority.rawValue, section: 0)], with: .automatic)
    }
}

extension RegisterViewController: TagDelegate {
    func sendTag(_ text: String) {
        self.tag = text
        registerView.tableView.reloadRows(at: [IndexPath(row: RegisterOptions.tag.rawValue, section: 0)], with: .automatic)
    }
}

extension RegisterViewController: DatePickerDelegate {
    func didSaveButtonTapped(date: Date) {
        self.date = date
        registerView.tableView.reloadRows(at: [IndexPath(row: RegisterOptions.deadline.rawValue, section: 0)], with: .automatic)
    }
}

extension RegisterViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.image = image as? UIImage
                    self.registerView.tableView.reloadData()
                }
            }
        }
        dismiss(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
