//
//  UIImageView+Image.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(name: String?) {
        log(.info,name)
        guard let name = name else {return}
        if let url = URL(string: name) {
            let image = UIImage(named: "category")
            self.kf.setImage(with: url, placeholder: image)
        } else {
            image = UIImage(named: name)
           
        }
    }
}
