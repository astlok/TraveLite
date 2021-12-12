import Foundation
import UIKit

struct UserAuth: Encodable {
    var email: String
    var password: String
}

struct UserCreateRequest: Encodable {
    var email: String
    var nickname: String
    var password: String
}

struct UserCheckAuthRequest {
    var authToken: String
    var id: Int
}

struct UserCreateResponse: Decodable {
    var id: Int
    var authToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case authToken = "auth_token"
    }
}

struct UserImage: Encodable, Decodable {
    var img: String
    var id: Int
}

struct UserProfile: Decodable {
    var id: Int
    var email: String
    var nickname: String
    var img: String?
    var authToken: String?
    var treksNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case img
        case authToken = "auth_token"
        case treksNumber = "treks_number"
    }
}
