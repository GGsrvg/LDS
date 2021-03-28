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
        
        let adapter = UITableViewAdapter<String, String, String>(
            tableView,
            observableArray: observable
        )
        adapter.cellForRowAction = { tableView, indexPath in
            //            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //
            //            if cell == nil {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            //            }
            
            cell.textLabel?.text = self.observable.array[indexPath.section].rows[indexPath.row]
            
            return cell
        }
        adapter.titleForHeaderSectionAction = { tableView, section in
            return self.observable.array[section].header
        }
        adapter.titleForFooterSectionAction = { tableView, section in
            return self.observable.array[section].footer
        }
        
        self.adapter = adapter
        
        tableView.dataSource = adapter
        
        test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.test()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.test()
        })
    }
    
    private func setTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }
    
    func test() {
        observable.addSections([
            .init(
                header: "S1 H",
                rows: ["S1 R1", "S1 R2"],
                footer: "S1 F"
            ),
            .init(
                header: "S2 H",
                rows: [],
                footer: "S2 F"
            ),
            .init(
                header: "S3 H",
                rows: [],
                footer: "S3 F"
            ),
        ])
        
//        observable.insertSections([
//            .init(
//                header: "S1 H",
//                rows: ["S1 R1", "S1 R2"],
//                footer: "S1 F"
//            ),
//            .init(
//                header: "S2 H",
//                rows: [],
//                footer: "S2 F"
//            ),
//            .init(
//                header: "S3 H",
//                rows: [],
//                footer: "S3 F"
//            ),
//        ], at: 0)
    }
}
