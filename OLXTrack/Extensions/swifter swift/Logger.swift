//
//  Logger.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import Foundation
enum LoggingLevels {
    case info, error
    var value: String {
        switch self {
        case .info:
            return "INFO>"
        case .error:
            return "ERROR>"
        }
    }
}

func log(_ level: LoggingLevels, _ value: Any?) {
    #if DEBUG
        if let _value = value {
            print("->\(level.value) \(_value)")
        } else {
            print("->\(level.value) nil")
        }
    #endif
}
