//
//  AppDelegate.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        _ = AppNavigator(window: window!)
        StartupLogicCommand().excute()
        return true
    }
}

class StartupLogicCommand {
    func excute() {
        check()
    }

    private func check() {
        let repo = CategoryRepo()
        if repo.getDefaultCategories().isEmpty {
            repo.createTable()
            let repos = Bundle.main.decode([CategoryItem].self,from:"DefaultCategories.json")
            for item in repos {
                repo.insert(cat: item)
            }
        }
    }
}
