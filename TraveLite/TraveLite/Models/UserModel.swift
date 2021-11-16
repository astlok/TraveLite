import Foundation

struct UserAuth: Encodable {
    var email: String
    var password: String
}

struct UserCreateRequest: Encodable {
    var email: String
    var nickname: String
    var password: String
}

struct UserCreateResponse: Decodable {
    var id: UInt64
    var authToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case authToken = "auth_token"
    }
}

struct UserProfile: Decodable {
    var id: UInt64
    var email: String
    var nickname: String
    var img: String?
    var authToken: String
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
