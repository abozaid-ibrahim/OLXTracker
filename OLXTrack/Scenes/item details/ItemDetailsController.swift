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
    var viewModel: ItemViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

    func bindToViewModel() {
        navigationItem.largeTitleDisplayMode = .always
        viewModel.title.subscribe { [unowned self] value in
            self.title = value
        }
        viewModel.quote.subscribe { [unowned self] value in
            self.quoteLbl.text = value
        }
        viewModel.image.subscribe { [unowned self] value in
            self.coverImageView.setImage(name: value ?? "")
        }
    }
}
