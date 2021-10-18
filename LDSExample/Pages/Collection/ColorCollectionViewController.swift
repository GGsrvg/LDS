//
//  ColorCollectionViewController.swift
//  LDSExample
//
//  Created by GGsrvg on 16.11.2020.
//

import UIKit
import LDS

class ColorCollectionViewController: UICollectionViewController {
    
    var adapter: UICollectionViewAdapter<ColorViewModel.SectionItemType>!
    
    let viewModel = ColorViewModel()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = .init(width: 66, height: 66)
            layout.minimumLineSpacing = 4
            layout.sectionInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        }
        
        adapter = .init(
            collectionView,
            cellForRowHandler:  { collectionView, indexPath, row in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = row
                return cell
            },
            viewForSupplementaryElementOfKindHandler: nil,
            numberOfSectionsHandler: nil,
            numberOfItemsInSectionHandler: nil
        )
        adapter.observableDataSource = viewModel.observable
        collectionView.dataSource = adapter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.sort()
    }
}
