//
//  TabBarViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 13.11.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setTabs()
    }
}

extension TabBarViewController {
    private func setTabs() {
        let tableViewController = ColorTableViewController()
        tableViewController.tabBarItem = UITabBarItem(title: "Table", image: nil, tag: 0)
        
        let collectionViewController = ColorCollectionViewController()
        collectionViewController.tabBarItem = UITabBarItem(title: "Collectionss", image: nil, tag: 1)
        
        self.viewControllers = [tableViewController, collectionViewController]
    }
}
