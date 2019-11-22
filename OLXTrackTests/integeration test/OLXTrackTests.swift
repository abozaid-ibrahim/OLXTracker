//
//  OLXTrackTests.swift
//  OLXTrackTests
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import XCTest
@testable import OLXTrack

class OLXTrackTests: XCTestCase {

    let categories:CategoryItemsGridViewModel
    override func setUp() {
        categories = CategoryItemsGridViewModel.init(apiClient: <#T##ApiClient#>, category: <#T##CategoryItem#>)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
