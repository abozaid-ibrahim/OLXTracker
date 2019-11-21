//
//  UIImageView+Image.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit


extension UIImageView {
    func setImage(name: String) {
        log(.info,name)
        if let url = URL(string: name) {
            kf.setImage(with: url)
        } else {
            image = UIImage(named: name)
        }
    }
}
