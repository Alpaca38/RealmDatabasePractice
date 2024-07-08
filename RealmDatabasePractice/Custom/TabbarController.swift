//
//  TabbarController.swift
//  RealmDatabasePractice
//
//  Created by 조규연 on 7/8/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .purple
        tabBar.unselectedItemTintColor = .gray
        
        let main = UINavigationController(rootViewController: FolderViewController())
        main.tabBarItem = UITabBarItem(title: "Folder", image: UIImage(systemName: "folder"), tag: 0)
        
        let like = UINavigationController(rootViewController: TotalSearchViewController())
        like.tabBarItem = UITabBarItem(title: "Total Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        setViewControllers([main, like], animated: true)
    }
}
