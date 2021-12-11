//
//  Trek.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 4/12/21.
//

import Foundation

struct Trek: Decodable {
    var id: Int
    var name: String
    var difficult: Int
    var days: Int
    var things: [String]
    var description: String
    var file: String
    var region: String
    var rating: Int
    var userID: Int
}

struct Treks {
    var treks: [Trek] = []
}

struct TrekCellModell {
    var id: Int
    var name: String
    
    var difficult: Int
    
    var days: Int
    
    var region: String
    
    var rating: Int
    
    init(with trek: Trek) {
        self.id = trek.id
        self.name = trek.name
        self.difficult = trek.difficult
        self.days = trek.days
        self.region = trek.region
        self.rating = trek.rating
    }
}
