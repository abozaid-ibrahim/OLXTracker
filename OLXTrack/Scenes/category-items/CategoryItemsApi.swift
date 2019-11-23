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
}

extension CategoryApi: RequestBuilder {
    var parameters: [String: Any] {
        switch self {
        case .items(let cat, let page):
            return ["method": "flickr.cameras.getBrandModels", "api_key": APIConstants.apiKey, "brand": cat, "format": "json", "nojsoncallback": "1","page":page.currentPage,"per_page":page.countPerPage]
        }
    }

    public var path: String {
        return ""
    }

    public var method: HttpMethod {
        return .get
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
