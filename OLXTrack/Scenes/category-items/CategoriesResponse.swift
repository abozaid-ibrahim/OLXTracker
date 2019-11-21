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

    enum CodingKeys: String, CodingKey {
        case cameras
        case stat
    }

    init(cameras: Cameras?, stat: String?) {
        self.cameras = cameras
        self.stat = stat
    }
}

// MARK: - Cameras

struct Cameras: Codable {
    let brand: String?
    let camera: [CategorySearchItem]?

    enum CodingKeys: String, CodingKey {
        case brand
        case camera
    }

    init(brand: String?, camera: [CategorySearchItem]?) {
        self.brand = brand
        self.camera = camera
    }
}


struct CategorySearchItem: Codable {
    let id: String?
    let name: Name?
    let images: ImageSizes?
    let details: Details?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images
        case details
    }

    init(id: String?, name: Name?, images: ImageSizes?, details: Details?) {
        self.id = id
        self.name = name
        self.images = images
        self.details = details
    }
}

// MARK: - Details

struct Details: Codable {
    let megapixels: LCDScreenSize?
    let lcdScreenSize: LCDScreenSize?
    let memoryType: Name?

    enum CodingKeys: String, CodingKey {
        case megapixels
        case lcdScreenSize
        case memoryType
    }

    init(megapixels: LCDScreenSize?, lcdScreenSize: LCDScreenSize?, memoryType: Name?) {
        self.megapixels = megapixels
        self.lcdScreenSize = lcdScreenSize
        self.memoryType = memoryType
    }
}

// MARK: - LCDScreenSize

struct LCDScreenSize: Codable {
    let content: Double?

    enum CodingKeys: String, CodingKey {
        case content = ""
    }

    init(content: Double?) {
        self.content = content
    }
}

// MARK: - Name

struct Name: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }

    init(content: String?) {
        self.content = content
    }
}

// MARK: - Images

struct ImageSizes: Codable {
    let small: Name?
    let large: Name?

    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
}
