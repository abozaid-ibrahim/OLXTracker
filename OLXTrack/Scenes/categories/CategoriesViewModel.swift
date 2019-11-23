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
    func showItems(of cat: CategoryItem, at position: Int)
    func loadData()
}

struct CategoriesListViewModel: CategoriesViewModel {
    private let dataRepository: CategoryRepository
    var categories: MObservable<[CategoryItem]> = MObservable<[CategoryItem]>()

    init(repo: CategoryRepository = CategoryRepo()) {
        self.dataRepository = repo
    }

    func loadData() {
        let sorted = self.dataRepository.getDefaultCategories().sorted { $0.visitsCount > $1.visitsCount  }
        self.categories.next(sorted)
    }

    func showItems(of cat: CategoryItem, at position: Int) {
        guard var values = categories.value else { return }
        values[position].IncrementVisits()
        categories.next(values.sorted { $0.visitsCount > $1.visitsCount  })
        self.dataRepository.incrementVistis(for: values[position])
        try? AppNavigator().push(.categoryItems(cat))
    }
}
