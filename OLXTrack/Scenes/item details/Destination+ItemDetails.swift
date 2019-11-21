//
//  Destination+ItemDetails.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension Destination {
    func getItemDetailsView(item:CategorySearchItem) -> UIViewController {
        let categoriesView = ItemDetailsController()
        categoriesView.viewModel = ItemDetailsViewModel(item: item)
        return categoriesView
    }
}
