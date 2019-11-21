//
//  DataExtension.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
extension Data {
    func toModel<T: Decodable>() -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: self)
        } catch {
            log(.error, ">>> parsing error \(error)")
            return nil
        }
    }

    var toString: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}
