//
//  CategoryCollectionCell.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Kingfisher
import UIKit
final class CategoryCollectionCell: UICollectionViewCell, UICell {
    typealias Model = (title: String, image: String)
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var titleLbl: UILabel!
    func setData(with model: Model) {
        titleLbl.text = model.title
        coverImageView.setImage(name: model.image)
    }
}
