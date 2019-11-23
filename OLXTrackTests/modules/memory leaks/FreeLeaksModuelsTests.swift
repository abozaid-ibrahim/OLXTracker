//
//  FreeLeaksModuelsTests.swift
//  OLXTrackTests
//
//  Created by abuzeid on 11/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import XCTest

import Nimble
@testable import OLXTrack
import Quick
import SpecLeaks
class FreeLeaksModuelsTests: QuickSpec {
    override func spec() {
        describe("MyViewController") {
            describe("must not leak") {
                it("categories Module") {
                    let vc = LeakTest {
                        Destination.categories.getCategoriesView()
                    }
                    expect(vc).toNot(leak())
                }
                it("categoriy items Module") {
                    let cat = CategoryItem(id: 1, visitsCount: 1, title: "apple", thumbnail: nil)
                    let vc = LeakTest {
                        Destination.categoryItems(cat).getCategoryItemsView(item: cat)
                    }
                    expect(vc).toNot(leak())
                }
                it("Item Details Module") {
                    let item = CategorySearchItem.init(id: "test", name: nil, images: nil, details: nil)
                    let vc = LeakTest {
                        Destination.itemDetails(item).getItemDetailsView(item: item)
                    }
                    expect(vc).toNot(leak())
                }
            }
        }
    }
}
