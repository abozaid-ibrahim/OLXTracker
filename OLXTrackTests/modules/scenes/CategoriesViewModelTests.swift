//
//  CategoriesViewModelTests.swift
//  OLXTrackTests
//
//  Created by abuzeid on 11/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

@testable import OLXTrack
import XCTest

class CategoriesViewModelTests: XCTestCase {
    var viewModel: CategoriesListViewModel!
    override func setUp() {
        viewModel = CategoriesListViewModel(repo: MockedCatRepo(), apiClient: MockedMoreCatsApiClient())
    }

    override func tearDown() {
        viewModel = nil
    }

    func testShowCategoreisFromRepo() {
        viewModel.loadData()
        XCTAssertEqual(viewModel.categories.value!.count, 3)
    }

    func testIncrmentVisitsCount() {
        viewModel.loadData()
        XCTAssertEqual(viewModel.categories.value!.count, 3)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        XCTAssertEqual(viewModel.categories.value!.first!.visitsCount, 3)
    }

    func testLoadMoreCategories() {
        XCTAssertNil(viewModel.categories.value)
        viewModel.loadMoreCategories()
        XCTAssertEqual(viewModel.categories.value!.count, 7)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        viewModel.showItems(of: MockedCatRepo.cats.first!, at: 0)
        XCTAssertEqual(viewModel.categories.value!.first!.visitsCount, 3)
    }

    func testParseDataFailure() {
        viewModel = CategoriesListViewModel(repo: MockedCatRepo(), apiClient: MockedFailureApiClient())
        viewModel.loadMoreCategories()
        XCTAssertEqual(viewModel.error.value!.localizedDescription, NetworkFailure.failedToParseData.localizedDescription)
    }
}

private class MockedCatRepo: CategoryRepository {
    static var cats = [CategoryItem(id: "sony", visitsCount: 0, title: "sony"),
                       CategoryItem(id: "apple", visitsCount: 0, title: "Apple"),
                       CategoryItem(id: "nikon", visitsCount: 0, title: "Nikon")]
    func getDefaultCategories() -> [CategoryItem] {
        return MockedCatRepo.cats
    }

    func incrementVistis(for cat: CategoryItem) {
        let index = MockedCatRepo.cats.firstIndex { $0.id == cat.id }
        MockedCatRepo.cats[index!].IncrementVisits()
    }
}

private class MockedMoreCatsApiClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let data = """
        { "brands": {
        "brand": [
          { "id": "apple", "name": "Apple" },
          { "id": "canon", "name": "Canon" },
          { "id": "nikon", "name": "Nikon" },
          { "id": "sony", "name": "Sony" },
          { "id": "fujifilm", "name": "Fujifilm" },
          { "id": "epson", "name": "Epson" },
          { "id": "helio", "name": "Helio" }
        ] }, "stat": "ok" }
        """.data(using: .utf8)!
        completionHandler(Result<Data, Error>.success(data))
    }
}

private class MockedFailureApiClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let data = NetworkFailure.failedToParseData
        completionHandler(Result<Data, Error>.failure(data))
    }
}
