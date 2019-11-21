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
    var title: MObservable<String> = MObservable()

    var image: MObservable<String> = MObservable()

    var quote: MObservable<String> = MObservable()

    var item: CategorySearchItem
    init(item: CategorySearchItem) {
        self.item = item
        title.next(item.name?.content ?? "")
        image.next(item.images?.large?.content ?? "")
        quote.next(randomQuote)
    }

    private var randomQuote: String {
        return "adfasdkfasdf"
    }
}
