//
//  CategoryItemsViewModel.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

protocol CategoryItemsViewModel {
    var showProgress: MObservable<Bool> { get }
    var categoryItems: MObservable<[CategorySearchItem]> { get }
    var error: MObservable<Error> { get }
    var title: MObservable<String> { get }
    func loadData()
    func showDetails(of item: CategorySearchItem)
}

struct CategoryItemsGridViewModel: CategoryItemsViewModel {
    // MARK: private state

    private var category: CategoryItem
    private let page = Page()
    private var network: ApiClient

    // MARK: Observers

    var showProgress: MObservable<Bool> = MObservable(false)
    var title: MObservable<String> = MObservable()
    var categoryItems: MObservable<[CategorySearchItem]> = MObservable()
    var error: MObservable<Error> = MObservable()
    /// initializier
    /// - Parameter apiClient: network handler
    init(apiClient: ApiClient = HTTPClient(), category: CategoryItem) {
        network = apiClient
        self.category = category
        title.next(category.title)
    }

    func showDetails(of item: CategorySearchItem) {
        try? AppNavigator().push(.itemDetails(item))
    }

    func loadData() {
        showProgress.next(true)
        let api = CategoryApi.items(cat: category.title, page: page)
        network.getData(of: api) { result in
            switch result {
                case .success(let data):
                    self.updateUI(with: data)
                case .failure(let error):
                    log(.error, error.localizedDescription)
                    self.error.next(error)
            }
            self.showProgress.next(false)
        }
    }

    private func updateUI(with data: Data) {
        log(.info, String(data: data, encoding: .utf8))
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(SearchResultJsonResponse.self, from: data)
            categoryItems.next(model.cameras?.camera ?? [])
        } catch {
            log(.error, error)
            self.error.next(NetworkFailure.failedToParseData)
        }
    }
}
