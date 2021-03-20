//
//  TableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class TableViewController: UIViewController {

    let observable: ObservableDataSource<String, String, String> = .init()
    
    var adapter: UITableViewAdapter<String, String, String>?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    private func setTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }
}
