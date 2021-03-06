//
//  CollectionViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class CollectionViewController: UICollectionViewController {
    
    var colors: [UIColor] = [
        .init(rgb: 0xff0000),
        .init(rgb: 0xff4000),
        .init(rgb: 0xff8000),
        .init(rgb: 0xffbf00),
        .init(rgb: 0xffff00),
        .init(rgb: 0xbfff00),
        .init(rgb: 0x80ff00),
        .init(rgb: 0x40ff00),
        .init(rgb: 0x00ff00),
        .init(rgb: 0x00ff40),
        .init(rgb: 0x00ff80),
        .init(rgb: 0x00ffbf),
        .init(rgb: 0x00ffff),
        .init(rgb: 0x00bfff),
        .init(rgb: 0x0080ff),
        .init(rgb: 0x0040ff),
        .init(rgb: 0x0000ff),
        .init(rgb: 0x4000ff),
        .init(rgb: 0x8000ff),
        .init(rgb: 0xbf00ff),
        .init(rgb: 0xff00ff),
        .init(rgb: 0xff00bf),
        .init(rgb: 0xff0080),
        .init(rgb: 0xff0040),
    ]
    
    let observable: ObservableDataSourceTwoDimension<String, UIColor, String> = .init()
    
    var adapter: UICollectionViewAdapter<String, UIColor, String>!
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.colors = self.colors.shuffled()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.colors = self.colors.shuffled()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = .init(width: self.view.frame.width, height: 12)
            layout.minimumLineSpacing = 2
        }
        
        adapter = .init(collectionView)
        adapter.observableDataSource = observable
        
        adapter.cellForRowHandler = { collectionView, indexPath, row in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = row
            return cell
        }
        
        collectionView.dataSource = adapter
        
//        observable.set(colors)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sort()
        testAdapter()
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
//                            self.observable.updateRow(jValue, at: j - 1)
//                            self.observable.updateRow(temp, at: j)
//                        }
//                    }
//                }
//            }
//        })
    }
    
    func testAdapter() {
        observable.set([
            .init(
                header: "",
                rows: [.blue],
                footer: ""
            ),
            .init(
                header: "",
                rows: [.blue],
                footer: ""
            ),
        ])
        
//        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(300), execute: {
//            DispatchQueue.main.sync {
                self.observable.addSections([
                    .init(
                        header: "",
                        rows: [.magenta],
                        footer: ""
                    ),
                    .init(
                        header: "",
                        rows: [.systemYellow],
                        footer: ""
                    ),
                    .init(
                        header: "",
                        rows: [.red],
                        footer: ""
                    ),
                ])
//            }
//        })
        
        observable.clear()

        observable.addSections([
            .init(
                header: "",
                rows: [.cyan, .darkGray],
                footer: ""
            ),
            .init(
                header: "",
                rows: [.purple, .brown],
                footer: ""
            ),
            .init(
                header: "",
                rows: [.green, .yellow],
                footer: ""
            ),
        ])

        observable.insertSections([.init(header: "", rows: [.red], footer: "")], at: 0)

        observable.removeSections(at: .init(integer: 0))

        observable.addRows([.blue], section: 0)
    }
}
