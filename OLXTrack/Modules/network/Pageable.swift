//
//  Pageable.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Foundation

final class Page {
    var currentPage: Int = 1
    var maxPages: Int = 2
    var countPerPage: Int = 12
    var isFetchingData = false
    var fetchedItemsCount = 0
    var shouldLoadMore: Bool {
       return (currentPage <= maxPages) && (!isFetchingData)
    }
}
