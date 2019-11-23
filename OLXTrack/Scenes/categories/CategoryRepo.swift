//
//  CategoryRepository.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
//
//  CategoryRepository.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
protocol CategoryRepository {
    func getDefaultCategories() -> [CategoryItem]
    func incrementVistis(for cat: CategoryItem)
}

final class CategoryRepo: CategoryRepository {
    private var db: SQLiteDatabase!
    init() {
        do {
            db = try SQLiteDatabase.open(path: DBConfig.path)
            log(.info, "Successfully opened connection to database.")
        } catch {
            log(.error, "Unable to open database. Verify that you created the directory described in the Getting Started section.")
        }
    }

    func getDefaultCategories() -> [CategoryItem] {
        return db.allCategories()
    }

    func incrementVistis(for cat: CategoryItem) {
        try? db.update(id: cat.id, newVisits: cat.visitsCount + 1)
    }
}

extension CategoryRepo {
    func createTable() {
        do {
            try db.createTable(table: CategoryItem.self)
        } catch {
            log(.error, db.errorMessage)
        }
    }

    func insert(cat: CategoryItem) {
        do {
            try db.insertCategory(cat: cat)
        } catch {
            log(.error, db.errorMessage)
        }
    }

    //    func read() {
    //        let first = db.category(id:  1)
    //        print("\(first?.id) \(first?.name)")
}
