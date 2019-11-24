//
//  CategoryApi.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import Foundation

enum CategoryApi {
    case items(cat: String, page: Page)
    case categories(page: Page)
}

extension CategoryApi: RequestBuilder {
    var parameters: [String: Any] {
        switch self {
        case let .items(cat, page):
            return ["method": "flickr.cameras.getBrandModels",
                    "api_key": APIConstants.apiKey,
                    "brand": cat,
                    "format": "json",
                    "nojsoncallback": "1",
                    "page": page.currentPage,
                    "per_page": page.countPerPage]
        case let .categories(page):
            return ["method": "flickr.cameras.getBrands",
                    "api_key": APIConstants.apiKey,
                    "format": "json",
                    "nojsoncallback": "1",
                    "page": page.currentPage,
                    "per_page": page.countPerPage]
        }
    }

    var method: HttpMethod {
        switch self {
        case .categories, .items:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
