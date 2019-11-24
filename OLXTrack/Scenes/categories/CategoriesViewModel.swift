//
//  CategoriesViewModel.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import Foundation

protocol CategoriesViewModel {
    var showProgress: MObservable<Bool> { get }
    var categories: MObservable<[CategoryItem]> { get }
    var error: MObservable<Error> { get }
    func showItems(of cat: CategoryItem, at position: Int)
    func loadMoreCategories()
    func loadData()
}

struct CategoriesListViewModel: CategoriesViewModel {
    private let dataRepository: CategoryRepository
    private let apiClient: ApiClient
    private let page = Page()

    let categories: MObservable<[CategoryItem]> = MObservable<[CategoryItem]>()
    let showProgress = MObservable<Bool>()
    let error = MObservable<Error>()
    init(repo: CategoryRepository = CategoryRepo(), apiClient: ApiClient = HTTPClient()) {
        dataRepository = repo
        self.apiClient = apiClient
    }

    func loadData() {
        let sorted = dataRepository.getDefaultCategories().sorted { $0.visitsCount ?? 0 > $1.visitsCount ?? 0 }
        categories.next(sorted)
    }

    func loadMoreCategories() {
        showProgress.next(true)
        let api = CategoryApi.categories(page: page)
        apiClient.getData(of: api) { result in
            switch result {
            case let .success(data):
                self.updateUI(with: data)
            case let .failure(error):
                log(.error, error.localizedDescription)
                self.error.next(error)
            }
            self.showProgress.next(false)
        }
    }

    private func updateUI(with data: Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(CategoriesResponse.self, from: data)
            categories.next(model.brands?.brand ?? [])
        } catch {
            log(.error, error)
            self.error.next(NetworkFailure.failedToParseData)
        }
    }

    func showItems(of cat: CategoryItem, at position: Int) {
        guard var values = categories.value else { return }
        values[position].IncrementVisits()
        categories.next(values.sorted { $0.visitsCount ?? 0 > $1.visitsCount ?? 0 })
        dataRepository.incrementVistis(for: values[position])
        try? AppNavigator().push(.categoryItems(cat))
    }
}
