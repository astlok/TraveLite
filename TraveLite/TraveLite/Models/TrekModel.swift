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

struct TrekCreateRequest: Encodable, Decodable {
    var name: String
    var difficult: Int
    var days: Int
//    var things: [UInt64]
    var description: String
    var file: String
    var region: String
}

struct TrekCreateResponse: Decodable {
    var id: Int
    var name: String
    var difficult: Int
    var days: Int
//    var things: [UInt64]
    var description: String
    var file: String
    var region: String
    var userID: Int
//    var rating: Float
//    var authToken: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case difficult
//        case days
//        case things
//        case description
//        case file
//        case region
//        case rating
//        case authToken = "auth_token"
//    }
}
