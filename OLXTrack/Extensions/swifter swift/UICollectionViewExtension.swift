//
//  UICollectionViewExtension.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNib(_ name: String) {
        register(UINib(nibName: name, bundle: .none), forCellWithReuseIdentifier: name)
    }

    func setThreeCellsLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemPadding = CGFloat(6)
        let itemsPerSection: Int = 3
        let margins = CGFloat(itemsPerSection + 1) * itemPadding
        let cellWidth = (bounds.width - margins) / CGFloat(itemsPerSection)
        let cellSize = CGSize(width: cellWidth, height: cellWidth)
        layout.itemSize = cellSize
        layout.sectionInset = .init(top: itemPadding, left: itemPadding, bottom: 0, right: itemPadding)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        setCollectionViewLayout(layout, animated: true)
    }
}
