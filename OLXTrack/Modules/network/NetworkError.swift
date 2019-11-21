//
//  NetworkError.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
enum NetworkFailure: LocalizedError {
    case unAcceptedResponse(String), failedToParseData, connectionFailed,noData
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
            
        default:
            return "\(self)"
            // "Check your connectivity"
        }
    }
}
