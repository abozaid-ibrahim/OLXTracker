//
//  CategoriesViewModel.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import Foundation

protocol CategoriesViewModel {
    var categories: MObservable<[CategoryItem]> { get }
    func showItems(of cat: CategoryItem)
    func loadData()
}

struct CategoriesListViewModel: CategoriesViewModel {
    private let dataRepository: CategoryRepository
    var categories: MObservable<[CategoryItem]> = MObservable<[CategoryItem]>()

    init(repo: CategoryRepository = CategoryRepo()) {
        dataRepository = repo
    }

    func loadData() {
        categories.next(dataRepository.defaultCategories)
    }

    func showItems(of cat: CategoryItem) {
        try? AppNavigator().push(.categoryItems(cat))
    }
}
