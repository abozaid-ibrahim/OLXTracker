//
//  UICell.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

protocol UICell: class {
    associatedtype Model
    func setData(with model: Model)
    static var identifier: String { get }
}

extension UICell {
    static var identifier: String {
        return String(describing: self)
    }
}
