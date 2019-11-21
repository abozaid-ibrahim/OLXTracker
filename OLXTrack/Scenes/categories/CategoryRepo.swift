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
}

final class CategoryRepo: CategoryRepository {
    private var db: SQLiteDatabase!
    init() {
        do {
            let part2DbPath = "categories"
            db = try SQLiteDatabase.open(path: part2DbPath)
            log(.info, "Successfully opened connection to database.")
        } catch {
            log(.error, "Unable to open database. Verify that you created the directory described in the Getting Started section.")
        }
    }

    func getDefaultCategories() -> [CategoryItem] {
        
        return []
    }

    private var categories: [CategoryItem] {
        let apple = CategoryItem(id: 0, visitsCount: 1, title: "Apple", thumbnail: "apple")
        let google = CategoryItem(id: 0, visitsCount: 1, title: "Google", thumbnail: "google")
        let facebook = CategoryItem(id: 0, visitsCount: 1, title: "Facebook", thumbnail: "facebook")
        let twitter = CategoryItem(id: 0, visitsCount: 1, title: "Twitter", thumbnail: "twitter")
        let linkedin = CategoryItem(id: 0, visitsCount: 1, title: "Linkedin", thumbnail: "linkedin")
        let olx = CategoryItem(id: 0, visitsCount: 1, title: "OLX Group", thumbnail: "olx")
        return [apple, google, facebook, twitter, linkedin, olx]
    }
}

private extension CategoryRepo {
    func createTable() {
        do {
            try db.createTable(table: CategoryItem.self)
        } catch {
            log(.error, db.errorMessage)
        }
    }

    func insert(cat: CategoryItem) {
        do {
            try db.insertContact(contact: cat)
        } catch {
            log(.error, db.errorMessage)
        }
    }

    //    func read() {
    //        let first = db.category(id:  1)
    //        print("\(first?.id) \(first?.name)")
    //    }
}
