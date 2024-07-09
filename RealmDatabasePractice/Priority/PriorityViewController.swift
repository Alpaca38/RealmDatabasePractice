//
//  PriorityViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit
import SnapKit

final class PriorityViewController: BaseViewController {
    weak var delegate: PriorityDelegate?
    private let viewModel = PriorityViewModel()
    
    private lazy var segmentControl = {
        let view = UISegmentedControl(items: Priority.allCases.map { $0.rawValue })
        view.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var priorityLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.sendPriority(viewModel.outputPriority.value)
    }
    
    override func configureLayout() {
        segmentControl.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        priorityLabel.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

private extension PriorityViewController {
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        viewModel.inputPriority.value = Priority.allCases[sender.selectedSegmentIndex].rawValue
    }
    
    func bindData() {
        viewModel.outputPriority.bind { [weak self] in
            guard let self else { return }
            priorityLabel.text = $0
        }
    }
}
