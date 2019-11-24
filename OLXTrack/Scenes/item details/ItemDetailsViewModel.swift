//
//  ItemDetailsViewModel.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

protocol ItemViewModel {
    var title: MObservable<String> { get }
    var image: MObservable<String> { get }
    var quote: MObservable<String> { get }
}

struct ItemDetailsViewModel: ItemViewModel {
    let title: MObservable<String> = MObservable()
    let image: MObservable<String> = MObservable()
    let quote: MObservable<String> = MObservable()
    let item: CategorySearchItem

    init(item: CategorySearchItem) {
        self.item = item
        title.next(item.name?.content ?? "")
        image.next(item.images?.large?.content ?? "")
        if let quotes = quotes {
            quote.next(quotes[self.randomIndex(quotes.count)])
        }
    }

    private func randomIndex(_ upperBound: Int) -> Int {
        return Int.random(in: 0..<upperBound)
    }

    private var quotes: [String]? = try? Bundle.main.decode([String].self, from: "quotes.json")
}
