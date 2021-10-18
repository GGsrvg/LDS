//
//  ColorTableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class ColorTableViewController: UITableViewController {
    
    var adapter: UITableViewAdapter<ColorViewModel.SectionItemType>!
    
    let viewModel = ColorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 24
        
        adapter = .init(
            tableView,
            cellForRowHandler: { tableView, indexPath, row in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.backgroundColor = row
                return cell
            },
            titleForHeaderSectionHandler: nil,
            titleForFooterSectionHandler: nil,
            numberOfSectionsHandler: nil,
            numberOfItemsInSectionHandler: nil
        )
        adapter.observableDataSource = viewModel.observable
        tableView.dataSource = adapter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.sort()
    }
}
