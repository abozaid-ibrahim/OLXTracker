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
        quote.next(self.quotes[self.randomIndex()])
    }
    private var randomIndex = {Int.random(in: 0...12)}
   

    private let quotes: [String] = ["I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best.", "Be yourself; everyone else is already taken.", "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.", "So many books, so little time.", "Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.", "A room without books is like a body without a soul.", "You only live once, but if you do it right, once is enough.", "In three words I can sum up everything I've learned about life: it goes on.", "No one can make you feel inferior without your consent.", "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.", "A friend is someone who knows all about you and still loves you.", "Always forgive your enemies; nothing annoys them so much.", "To live is the rarest thing in the world. Most people exist, that is all."]
}
