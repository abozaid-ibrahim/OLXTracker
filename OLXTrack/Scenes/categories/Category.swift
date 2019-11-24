//
//  Category.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct CategoriesResponse: Codable {
    let brands: Brands?
    let stat: String?
}

struct Brands: Codable {
    let brand: [CategoryItem]?
}

struct CategoryItem: Codable {
    let id: String
    var visitsCount: Int? = 0
    let title: String
    enum CodingKeys: String, CodingKey {
        case id
        case visitsCount
        case title = "name"
    }

    mutating func IncrementVisits() {
        visitsCount = (visitsCount ?? 0) + 1
    }
}

extension CategoryItem: SQLTable {
    static var createStatement: String {
        return """
        CREATE TABLE CategoryItem(
          Id CHAR(255) PRIMARY KEY NOT NULL,
          Name CHAR(255),
          visits INT NOT NULL
        );
        """
    }
}
