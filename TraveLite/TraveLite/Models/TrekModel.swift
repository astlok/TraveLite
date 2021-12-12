//
//  TrekModel.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 05.12.2021.
//

import Foundation

//{
//  "id": 228,
//  "name": "Муринские топи",
//  "difficult": 3,
//  "days": 4,
//  "things": [
//    "Водка",
//    "Побольше водки"
//  ],
//  "description": "Самый лучший поход, 4 дня, 5км, 20 литров водки",
//  "file": "findfreelancer/kek.kml",
//  "region": "Москва и МО",
//  "rating": 4.2
//}

struct TrekCreateRequest: Decodable {
    var name: String
    var difficult: UInt64
    var days: UInt64
//    var things: [UInt64]
    var description: String
    var file: String
    var region: String
//    var authToken: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case difficult
        case days
//        case things
        case description
        case file
        case region
//        case authToken = "auth_token"
    }
}

struct TrekCreateResponse: Decodable {
    var id: UInt64
    var name: String
    var difficult: UInt64
    var days: UInt64
    var things: [UInt64]
    var description: String
    var file: String
    var region: String
    var rating: Float
    var authToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case difficult
        case days
        case things
        case description
        case file
        case region
        case rating
        case authToken = "auth_token"
    }
}
