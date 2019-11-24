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
        viewModel = CategoriesListViewModel(repo: MockedCatRepo())
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
}

class MockedCatRepo: CategoryRepository {
    static var cats = [CategoryItem(id: "1", visitsCount: 0, title: "Google"),
                       CategoryItem(id: "2", visitsCount: 0, title: "Apple"),
                       CategoryItem(id: "3", visitsCount: 0, title: "Amazon")]
    func getDefaultCategories() -> [CategoryItem] {
        return MockedCatRepo.cats
    }

    func incrementVistis(for cat: CategoryItem) {
        let index = MockedCatRepo.cats.firstIndex { $0.id == cat.id }
        MockedCatRepo.cats[index!].IncrementVisits()
    }
}
