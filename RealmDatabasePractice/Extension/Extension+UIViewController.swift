//
//  Extension+UIViewController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/2/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String,message: String, ok: String, handler: @escaping (() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
