//
//  SQLiteDatabaseTests.swift
//  OLXTrackTests
//
//  Created by abuzeid on 11/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

@testable import OLXTrack
import XCTest

class SQLiteDatabaseTests: XCTestCase {
    var sqlDB: SQLiteDatabase!
    override func setUp() {
        let path: String = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("\(Date())test.sqlite").absoluteString
        sqlDB = try! SQLiteDatabase.open(path: path)
    }

    override func tearDown() {
        sqlDB = nil
    }

    func testCRUD_Operations() {
        let google = CategoryItem(id: 1, visitsCount: 0, title: "Google", thumbnail: nil)
        do {
            try sqlDB.createTable(table: CategoryItem.self)
            try sqlDB.insertCategory(cat: google)
            XCTAssertEqual(sqlDB.allCategories().count, 1)
            try sqlDB.update(id: 1, newVisits: 5)
            let newRecord = sqlDB.category(id: 1)
            XCTAssertEqual(newRecord!.visitsCount, 5)
        } catch {
            print(error)
            XCTFail()
        }
    }
}
