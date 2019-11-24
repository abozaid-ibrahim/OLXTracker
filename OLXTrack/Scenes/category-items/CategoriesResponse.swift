//
//  CategoriesResponse.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct SearchResultJsonResponse: Codable {
    let cameras: Cameras?
    let stat: String?
}

struct Cameras: Codable {
    let brand: String?
    let camera: [CategorySearchItem]?
}

struct CategorySearchItem: Codable {
    let id: String?
    let name: Name?
    let images: ImageSizes?
    let details: Details?
}

struct Details: Codable {
    let memoryType: Name?
}

struct Name: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

struct ImageSizes: Codable {
    let small: Name?
    let large: Name?
}
