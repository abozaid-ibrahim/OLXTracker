//
//  SQLiteDatabase+CRUD.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import SQLite3

extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        defer {
            sqlite3_finalize(createTableStatement)
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        log(.info, "\(table) table created.")
    }

    func insertContact(contact: CategoryItem) throws {
        let insertSql = "INSERT INTO CategoryItem (Id, Name, visits) VALUES (?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }

        let title: NSString = NSString(string: contact.title)

        guard sqlite3_bind_int(insertStatement, 1, Int32(contact.id)) == SQLITE_OK,
            sqlite3_bind_text(insertStatement, 2, title.utf8String, -1, nil) == SQLITE_OK,
            sqlite3_bind_int(insertStatement, 3, Int32(contact.visitsCount)) == SQLITE_OK else {
            throw SQLiteError.Bind(message: errorMessage)
        }

        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }

        log(.info, "Successfully inserted row.")
    }

    func category(id: Int32) -> CategoryItem? {
        let querySql = "SELECT * FROM CategoryItem WHERE Id = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }

        defer {
            sqlite3_finalize(queryStatement)
        }

        guard sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK else {
            return nil
        }

        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }

        let id = sqlite3_column_int(queryStatement, 0)
        let visits = sqlite3_column_int(queryStatement, 2)
        let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
        let name = String(cString: queryResultCol1!) as NSString

        return CategoryItem(id: Int(id), visitsCount: Int(visits), title: String(name), thumbnail: "")
    }
}
