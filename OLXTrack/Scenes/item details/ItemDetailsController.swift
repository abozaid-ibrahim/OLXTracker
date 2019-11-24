//
//  ItemDetailsController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

final class ItemDetailsController: UIViewController {
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var quoteLbl: UILabel!
    private var imageDownloader: Disposable?

    var viewModel: ItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

    func bindToViewModel() {
        navigationItem.largeTitleDisplayMode = .always
        viewModel.title.subscribe { [weak self] value in
            self?.title = value
        }
        viewModel.quote.subscribe { [weak self] value in
            self?.quoteLbl.text = value
        }
        viewModel.image.subscribe { [weak self] value in
            guard let self = self else { return }
            if let url = URL(string: value ?? "") {
                self.imageDownloader = ImageDownloader().downloadImageWith(url: url, placeholder: UIImage(named: "category"), imageView: self.coverImageView)
            }
        }
    }

    deinit {
        imageDownloader?.dispose()
    }
}
