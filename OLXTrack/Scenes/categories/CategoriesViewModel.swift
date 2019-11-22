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
        dataRepository = repo
    }

    func loadData() {
        DispatchQueue.global().async {
            let sorted = self.dataRepository.getDefaultCategories().sorted { (item, item2) -> Bool in
                item.visitsCount > item2.visitsCount
            }
            self.categories.next(sorted)
        }
    }

    func showItems(of cat: CategoryItem, at position: Int) {
        guard var values = categories.value else { return }
        values[position].IncrementVisits()
        dataRepository.incrementVistis(for: values[position])
        try? AppNavigator().push(.categoryItems(cat))
    }
}
