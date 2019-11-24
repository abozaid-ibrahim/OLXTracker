//
//  CategoryCollectionCell.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
final class CategoryCollectionCell: UICollectionViewCell, UICell {
    typealias Model = (title: String, image: String?)
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var titleLbl: UILabel!
    private var imageDownloader: Disposable?
    func setData(with model: Model) {
        titleLbl.text = model.title
        if let url = URL(string: model.image ?? "") {
            imageDownloader = ImageDownloader().downloadImageWith(url: url, placeholder: UIImage(named: "category"), imageView: coverImageView)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloader?.dispose()
    }
}
