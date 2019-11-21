//
//  Destination.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
enum Destination {
    case categories,
        categoryItems(CategoryItem),
        itemDetails(CategorySearchItem)

    func controller() -> UIViewController {
        switch self {
        case .categories:
            return getCategoriesView()
        case .categoryItems(let category):
            return getCategoryItemsView(item: category)
        case .itemDetails(let item):
            return getItemDetailsView(item: item)
        }
    }
}
