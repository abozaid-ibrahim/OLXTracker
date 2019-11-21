//
//  CategoryRepository.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
protocol CategoryRepository {
    var defaultCategories: [CategoryItem] { get }
}

final class CategoryRepo: CategoryRepository {
    var defaultCategories: [CategoryItem] {
        let apple = CategoryItem(id: 0, visitsCount: 1, title: "Apple", thumbnail: "apple")
        let google = CategoryItem(id: 0, visitsCount: 1, title: "Google", thumbnail: "google")
        let facebook = CategoryItem(id: 0, visitsCount: 1, title: "Facebook", thumbnail: "facebook")
        let twitter = CategoryItem(id: 0, visitsCount: 1, title: "Twitter", thumbnail: "twitter")
        let linkedin = CategoryItem(id: 0, visitsCount: 1, title: "Linkedin", thumbnail: "linkedin")
        let olx = CategoryItem(id: 0, visitsCount: 1, title: "OLX Group", thumbnail: "olx")
        return [apple, google, facebook, twitter, linkedin, olx]
    }
}
