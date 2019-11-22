//
//  NetworkError.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
enum NetworkFailure: LocalizedError {
    case unAcceptedResponse(String), failedToParseData, connectionFailed, noData, badRequest
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        case .unAcceptedResponse(let err):
            return "unexpected response: \(err)"
        case .connectionFailed:
            return "Check your connectivity"
        case .noData:
           return "there is no data"
        case .badRequest:
           return "something is missing, you have bad request"
        }
    }
}
