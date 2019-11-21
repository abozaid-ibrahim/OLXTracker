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
    func incrementVistis(for cat:CategoryItem)
}

final class CategoryRepo: CategoryRepository {
    private var db: SQLiteDatabase!
    init() {
        do {
            db = try SQLiteDatabase.open()
            log(.info, "Successfully opened connection to database.")
        } catch {
            log(.error, "Unable to open database. Verify that you created the directory described in the Getting Started section.")
        }
    }

    func getDefaultCategories() -> [CategoryItem] {
        return db.allCategories()
    }
    func incrementVistis(for cat:CategoryItem){
        try? db.update(id: cat.id, newVisits: cat.visitsCount+1)
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
            try db.insertContact(contact: cat)
        } catch {
            log(.error, db.errorMessage)
        }
    }

    //    func read() {
    //        let first = db.category(id:  1)
    //        print("\(first?.id) \(first?.name)")
    //    }
    
     var categories: [CategoryItem] {
           let apple = CategoryItem(id: 1, visitsCount: 1, title: "Apple", thumbnail: "apple")
           let google = CategoryItem(id: 2, visitsCount: 1, title: "Google", thumbnail: "google")
           let facebook = CategoryItem(id: 3, visitsCount: 1, title: "Facebook", thumbnail: "facebook")
           let twitter = CategoryItem(id: 4, visitsCount: 1, title: "Twitter", thumbnail: "twitter")
           let linkedin = CategoryItem(id: 5, visitsCount: 1, title: "Linkedin", thumbnail: "linkedin")
           let olx = CategoryItem(id: 6, visitsCount: 1, title: "OLX Group", thumbnail: "olx")
           return [apple, google, facebook, twitter, linkedin, olx]
       }
}
