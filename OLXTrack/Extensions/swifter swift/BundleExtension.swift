//
//  BundleExtension.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import Foundation

extension Bundle {
    func decode<T: Decodable>(_: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw NetworkFailure.badRequest
        }

        guard let data = try? Data(contentsOf: url) else {
            throw NetworkFailure.noData
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            log(.error, error)
            throw NetworkFailure.failedToParseData
        }
    }
}
