//
//  CategoriesViewModel.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

protocol CategoriesViewModel {
    var showProgress: Observable<Bool> { get }
    var categories: Observable<[QCategory]> { get }
    var error: Observable<Error> { get }
    func showQuestionsList(of category: QCategory)
    func loadData()
}

struct CategoriesListViewModel: CategoriesViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let dataRepository: QuestionsRepository
    private let _categories = PublishSubject<[QCategory]>()
    private let _showProgress = PublishSubject<Bool>()
    private let _error = PublishSubject<Error>()
    private var currentCategory: QCategory?

    // MARK: Observers

    var showProgress: Observable<Bool> {
        return _showProgress.asObservable()
    }

    var categories: Observable<[QCategory]> {
        return _categories.asObservable()
    }

    var error: Observable<Error> {
        return _error.asObservable()
    }

    /// initializier
    /// - Parameter apiClient: network handler
    init(repo: QuestionsRepository = QuestionsRepo()) {
        dataRepository = repo
    }

    func loadData() {
        _categories.onNext(dataRepository.loadCategories())
    }

    func showQuestionsList(of category: QCategory) {
        try? AppNavigator().push(.questions(category))
    }
}
