//
//  TableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class TableViewController: UITableViewController {
    
    let colors: [UIColor] = [
        .purple,
        .yellow,
        .blue,
        .orange,
        .cyan,
        .red,
        .green,
        .init(rgb: 0x800000),
        .init(rgb: 0x8B0000),
        .init(rgb: 0x778899),
        .init(rgb: 0xF0FFF0),
        .init(rgb: 0x8A2BE2),
        .init(rgb: 0xE0FFFF),
        .init(rgb: 0xFF7F50),
        .init(rgb: 0xE0FFFF),
        .init(rgb: 0x191970),
        .init(rgb: 0x00BFFF),
        .init(rgb: 0xFFDAB9),
        .init(rgb: 0xBA55D3),
        .init(rgb: 0xFFFF00),
        .init(rgb: 0x1E90FF),
    ]
    
    let observable: ObservableDataSource<String?, UIColor, String?> = .init()
    
    var adapter: UITableViewAdapter<String?, UIColor, String?>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 24
        
        adapter = .init(
            tableView,
            observableArray: observable
        )
        
        adapter.cellForRowAction = { tableView, indexPath, row in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    //        cell.textLabel?.text = "\(observable.array[indexPath.section].rows[indexPath.row])"
            cell.backgroundColor = row
            return cell
        }
        
        tableView.dataSource = adapter
        
        observable.set([
            .init(
                header: nil,
                rows: colors,
                footer: nil
            )
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sort()
    }
    
    func sort() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            for i in 0..<(self.observable.array[0].rows.count) {
                for j in 1..<(self.observable.array[0].rows.count - i) {
                    let jValue = self.observable.array[0].rows[j]
                    let temp = self.observable.array[0].rows[j - 1]
                    
                    if jValue.hue < temp.hue {
                        
                        self.observable.updateRow(jValue, section: 0, at: j - 1)
                        self.observable.updateRow(temp, section: 0, at: j)
                    }
                }
            }
        })
    }
}
