//
//  Destination.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
enum Destination {
    case categories,
        questions(QCategory)

    func controller() -> UIViewController {
        switch self {
        case .categories:
            return getCategoriesView()
        case let .questions(cat):
            return getQuestionsView(for: cat)
        }
    }
}
