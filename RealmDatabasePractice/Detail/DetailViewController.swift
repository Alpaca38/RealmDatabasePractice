//
//  DetailViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

final class DetailViewController: UIViewController {
    private let detailView = DetailView()
    let viewModel = DetailViewModel()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
}

private extension DetailViewController {
    func bindData() {
        viewModel.outputTodo.bind { [weak self] todo in
            guard let todo else { return }
            self?.detailView.configure(todo: todo)
        }
    }
}
