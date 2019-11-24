//
//  StartupLogic.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

final class StartupLogicCommand {
    func excute() {
        addDefaultCategoriesToDatabase()
    }

    private func addDefaultCategoriesToDatabase() {
        let repo = CategoryRepo()
        if repo.getDefaultCategories().isEmpty {
            repo.createTable()
            guard let repos = try? Bundle.main.decode([CategoryItem].self, from: "defaultCategories.json") else { return }
            for item in repos {
                repo.insert(cat: item)
            }
        }
    }
}
