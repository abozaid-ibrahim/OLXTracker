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
    let path = try! FileManager.default
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("\(Date())_test.sqlite")

    override func setUp() {
        sqlDB = try! SQLiteDatabase.open(path: path.absoluteString)
        print(path)
    }

    override func tearDown() {
        sqlDB = nil
        clearAllFile(path.absoluteURL)
    }

    func testCRUD_Operations() {
        let google = CategoryItem(id: "1", visitsCount: 0, title: "Google")
        do {
            try sqlDB.createTable(table: CategoryItem.self)
            try sqlDB.insertCategory(cat: google)
            XCTAssertEqual(sqlDB.allCategories().count, 1)
            try sqlDB.update(id: "1", newVisits: 5)
            let newRecord = sqlDB.category(id: "1")
            XCTAssertEqual(newRecord!.visitsCount, 5)
        } catch {
            print(error)
            XCTFail()
        }
    }

    func clearAllFile(_ url: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
        } catch {
            log(.error, error)
        }
    }
}

