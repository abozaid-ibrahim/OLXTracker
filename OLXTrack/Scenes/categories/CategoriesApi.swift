//
//  ModelApi.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import Foundation

enum CategoriesApi {
    case cats(key: String, manufacturer: String, page: Int, pageSize: Int)
}

extension CategoriesApi: RequestBuilder {
    var parameters: [String: Any] {
        return ["q": "Apple"]
    }
    
    public var path: String {
        return "search"
    }
    
    public var method: HttpMethod {
        return .get
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
