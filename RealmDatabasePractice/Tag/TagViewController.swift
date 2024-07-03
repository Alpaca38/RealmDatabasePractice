//
//  TagViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import SnapKit

final class TagViewController: UIViewController {
    weak var delegate: TagDelegate?
    
    private lazy var tagTextField = {
        let view = UITextField()
        view.placeholder = "태그를 입력해주세요."
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.sendTag(tagTextField.text!)
    }
    
    private func configureLayout() {
        tagTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
    }
}
