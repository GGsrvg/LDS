//
//  TableViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class TableViewController: UITableViewController {
    
//    var colors: [UIColor] = [
//        .init(rgb: 0xff0000),
//        .init(rgb: 0xff4000),
//        .init(rgb: 0xff8000),
//        .init(rgb: 0xffbf00),
//        .init(rgb: 0xffff00),
//        .init(rgb: 0xbfff00),
//        .init(rgb: 0x80ff00),
//        .init(rgb: 0x40ff00),
//        .init(rgb: 0x00ff00),
//        .init(rgb: 0x00ff40),
//        .init(rgb: 0x00ff80),
//        .init(rgb: 0x00ffbf),
//        .init(rgb: 0x00ffff),
//        .init(rgb: 0x00bfff),
//        .init(rgb: 0x0080ff),
//        .init(rgb: 0x0040ff),
//        .init(rgb: 0x0000ff),
//        .init(rgb: 0x4000ff),
//        .init(rgb: 0x8000ff),
//        .init(rgb: 0xbf00ff),
//        .init(rgb: 0xff00ff),
//        .init(rgb: 0xff00bf),
//        .init(rgb: 0xff0080),
//        .init(rgb: 0xff0040),
//    ]
    
//    let observable: LDS.ObservableArray<SectionItem<Never, UIColor, Never>> = .init()
    
    var adapter: UITableViewAdapter<String?, UIColor, String?>!
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.colors = self.colors.shuffled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 24
        
//        adapter = .init(tableView)
//        adapter.observableDataSource = observable
//
//        adapter.cellForRowHandler = { tableView, indexPath, row in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
//    //        cell.textLabel?.text = "\(observable.array[indexPath.section].rows[indexPath.row])"
//            cell.backgroundColor = row
//            return cell
//        }
        
        tableView.dataSource = adapter
        
//        observable.set(colors)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sort()
    }
    
    func sort() {
//        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(300), execute: {
//            for i in 0..<(self.observable.array.count) {
//                for j in 1..<(self.observable.array.count - i) {
//                    let jValue = self.observable.array[j]
//                    let temp = self.observable.array[j - 1]
//
//                    if jValue.hue < temp.hue {
//                        DispatchQueue.main.sync {
//                            self.observable.replaceRow(jValue, at: j - 1)
//                            self.observable.replaceRow(temp, at: j)
//                        }
//                    }
//                }
//            }
//        })
    }
}
