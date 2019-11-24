//
//  CategoryItemsViewModelTests.swift
//  OLXTrackTests
//
//  Created by abuzeid on 11/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

@testable import OLXTrack
import XCTest

class CategoryItemsViewModelTests: XCTestCase {
    var itemsViewModel: CategoryItemsGridViewModel!
    let apple = CategoryItem(id: "1", visitsCount: 1, title: "Apple")
    override func setUp() {
        itemsViewModel = CategoryItemsGridViewModel(apiClient: MockedApiClient(), category: apple)
    }

    override func tearDown() {
        itemsViewModel = nil
    }

    func testGetCategoryItemsFromBackend() {
        itemsViewModel.loadData()
        let categoriesExpect = expectation(description: "wait until recieve value")

        itemsViewModel.categoryItems.subscribe { values in
            XCTAssertEqual(values!.count, 9)
            categoriesExpect.fulfill()
        }
        XCTAssertEqual(itemsViewModel.title.value!, "Apple")
        wait(for: [categoriesExpect], timeout: 1)
    }

    func testFailedToGetDataMessage() {
        itemsViewModel = CategoryItemsGridViewModel(apiClient: MockedFailureApiClient(), category: apple)
        itemsViewModel.loadData()
        XCTAssertEqual(itemsViewModel.error.value!.localizedDescription, NetworkFailure.noData.localizedDescription)
    }
}

class MockedApiClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let data = """
        {"cameras":{"brand":"google","camera":[{"id":"pixel_3","name":{"_content":"Google Pixel 3"}},{"id":"pixel_2","name":{"_content":"Google Pixel 2"}},{"id":"pixel_3_xl","name":{"_content":"Google Pixel 3 XL"}},{"id":"pixel_3a","name":{"_content":"Google Pixel 3a"}},{"id":"pixel","name":{"_content":"Google Pixel"}},{"id":"pixel_3a_xl","name":{"_content":"Google Pixel 3a XL"}},{"id":"pixel_4_xl","name":{"_content":"Google Pixel 4 XL"}},{"id":"pixel_4","name":{"_content":"Google Pixel 4"}},{"id":"glass","name":{"_content":"Google Glass"}}]},"stat":"ok"}
        """.data(using: .utf8)!
        completionHandler(Result<Data, Error>.success(data))
    }
}

class MockedFailureApiClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let data = NetworkFailure.noData
        completionHandler(Result<Data, Error>.failure(data))
    }
}
