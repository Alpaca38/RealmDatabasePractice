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
    private var selectedPriority: String?
    
    private lazy var segmentControl = {
        let view = UISegmentedControl(items: Priority.allCases.map { $0.rawValue })
        view.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        self.view.addSubview(view)
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedPriority else { return }
        delegate?.sendPriority(selectedPriority)
    }
    
    override func configureLayout() {
        segmentControl.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
    }
}

private extension PriorityViewController {
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        selectedPriority = Priority.allCases[sender.selectedSegmentIndex].rawValue
    }
}
