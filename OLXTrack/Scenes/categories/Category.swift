//
//  Category.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
struct CategoryItem {
    let id: Int
    let visitsCount: Int
    let title: String
    let thumbnail: String
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
