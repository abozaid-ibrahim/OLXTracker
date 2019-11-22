//
//  Category.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
struct CategoryItem: Decodable {
    let id: Int
    var visitsCount: Int
    let title: String
    let thumbnail: String?
    mutating func IncrementVisits() {
        self.visitsCount += 1
    }
}

extension CategoryItem: SQLTable {
    var primaryKey: String {
        String(self.id)
    }

    static var createStatement: String {
        return """
        CREATE TABLE CategoryItem(
          Id INT PRIMARY KEY NOT NULL,
          Name CHAR(255),
          visits INT NOT NULL
        );
        """
    }
}
