//
//  Destination+Categories.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension Destination {
    func getCategoriesView() -> UIViewController {
        let categoriesView = CategoriesViewController()
        categoriesView.viewModel = CategoriesListViewModel()
        return categoriesView
    }
}
