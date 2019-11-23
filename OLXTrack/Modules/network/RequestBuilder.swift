//
//  RequestBuilder.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    var baseURL: String { get }

    var path: String { get }

    var method: HttpMethod { get }

    var parameters: [String: Any] { get }
    var task: URLRequest { get }
}

extension RequestBuilder {
    var description: String {
        return "\(endpoint), \(parameters)"
    }

    var endpoint: URL {
        return URL(string: "\(baseURL)\(path)")!
    }

    var baseURL: String {
        return APIConstants.baseURL
    }

    var task: URLRequest {
        var items = [URLQueryItem]()
        var myURL = URLComponents(string: endpoint.absoluteString)
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        myURL?.queryItems = items
        var request = URLRequest(url: myURL!.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        return request
    }
}

public enum HttpMethod: String {
    case get, post
}

struct APIConstants {
    static let baseURL = "https://www.flickr.com/services/rest/"
    static let apiKey = "be03809a807f07ee33e1347357e6fd0a"
    static let timeout: TimeInterval = 30
    static let secretKey = "ab1447132d9124c9"
}

