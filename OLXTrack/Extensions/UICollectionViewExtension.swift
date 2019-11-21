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
        self.register(UINib(nibName: name, bundle: .none), forCellWithReuseIdentifier: name)
    }

    func number(of sections: Int, ofArray count: Int) -> Int {
        return count / sections + (count % sections > 0 ? 1 : 0)
    }

    func numberOfItems(in section: Int, count: Int, itms: Int) -> Int {
        if section >= (count / itms), count % itms > 0 {
            return count % itms
        }
        return itms
    }

    func itemIndex(of indexPath: IndexPath, in itemsPerSection: Int) -> Int {
        return (indexPath.section * itemsPerSection) + indexPath.row
    }
}
