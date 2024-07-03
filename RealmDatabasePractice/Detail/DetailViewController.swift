//
//  DetailViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/3/24.
//

import UIKit

final class DetailViewController: UIViewController {
    private let detailView = DetailView()
    var todo: Todo?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let todo else { return }
        detailView.configure(todo: todo)
    }
    
}
