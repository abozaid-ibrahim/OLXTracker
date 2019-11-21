//
//  CategoriesResponse.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct SearchResultJsonResponse: Codable {
    let imagesResults: [CategorySearchItem]
}

struct CategorySearchItem: Codable {
    let title: String
    let thumbnail: String
}

struct CategoryItem {
    let id: Int
    let visitsCount: Int
    let title: String
    let thumbnail: String
}

// {
// ...
// "images_results": [
//  {
//    "position": "Integer - Image index",
//    "thumbnail": "String - Google Thumbnail URL (cache)",
//    "original": "String - Original Image URL (full resolution)",
//    "title": "String - Short Image Description",
//    "link": "String - Link to the page providing the image",
//    "source": "String - Original Domain Name"
//  },
//  "suggested_searches": [
//  {
//    "name": "String - suggested searches name",
//    "link": "String - Google search link original",
//    "chips": "String - Google chips parameter value",
//    "serpapi_link": "String - Link to SerpApi to fetch the suggested searches",
//    "thumbnail": "String - URL or base64 encoded image thumbnail displayed by Google"
