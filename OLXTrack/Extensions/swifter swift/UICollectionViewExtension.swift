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
}
