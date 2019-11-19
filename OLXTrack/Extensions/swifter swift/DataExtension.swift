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
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            log(.error, ">>> parsing error \(error)")
            return nil
        }
    }

    var toString: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}
