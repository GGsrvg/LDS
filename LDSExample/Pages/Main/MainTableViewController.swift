//
//  MainTableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 22.10.2021.
//

import UIKit
import LDS

class MainTableViewController: UITableViewController {
    
    var adapter: UITableViewAdapter<MainViewModel.SectionItemType>!
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = UITableViewAdapter(
            tableView,
            cellForRowHandler: { tableView, indexPath, row in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.accessoryType = .disclosureIndicator
                if #available(iOS 14.0, *) {
                    var content = cell.defaultContentConfiguration()
                    content.text = row
                    cell.contentConfiguration = content
                } else {
                    cell.textLabel?.text = row
                }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let vc: UIViewController
        
        switch indexPath.row {
        case 0:
            vc = UIViewController()
        case 1:
            vc = ColorCollectionViewController()
        case 2:
            vc = ColorTableViewController()
        default:
            return
        }
        
        self.showDetailViewController(vc, sender: nil)
    }
}
