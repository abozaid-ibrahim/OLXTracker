//
//  Destination+CategoryItems
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension Destination {
    func getCategoryItemsView(item: CategoryItem) -> UIViewController {
        let categoriesView = CategoryItemsController()
        categoriesView.viewModel = CategoryItemsGridViewModel(category: item)
        return categoriesView
    }
}
