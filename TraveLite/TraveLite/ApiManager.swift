import Foundation
import UIKit

enum NetworkError: Error{
    case unexpected
}

protocol ApiManagerDescription {
    func regUser(with user: UserCreateRequest, completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func authUser(with user: UserAuth, completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func changeProfileImage(with userImage: UserImage, token: String, completion: @escaping (Result<UserImage, Error>) -> Void)
    
    func changeProfile(with userImage: UserCreateRequest, token: String, completion: @escaping (Result<UserCreateRequest, Error>) -> Void)
    
    func exit(token: String, completion: @escaping (Result<Bool, Error>) -> Void)
  
    func checkAuth(with user: UserCheckAuthRequest, completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func loadTreks(token: String, completion: @escaping (Result<Treks, Error>) -> Void)
    
    func createTrek(trek: TrekCreateRequest, token: String, completion: @escaping (Result<TrekCreateResponse, Error>) -> Void)

}

final class ApiManager: ApiManagerDescription {
    func createTrek(trek: TrekCreateRequest, token: String, completion: @escaping (Result<TrekCreateResponse, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/trek") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("\(token)", forHTTPHeaderField: "X-Auth-token")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(trek)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
//                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode(TrekCreateResponse.self, from: data)
  
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func exit(token: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/logout") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("\(token)", forHTTPHeaderField: "X-Auth-token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(true))
        }
        task.resume()
    }
    
    
    static let shared: ApiManagerDescription = ApiManager()
    
    private init() {}
    
    func changeProfile(with user: UserCreateRequest, token: String, completion: @escaping (Result<UserCreateRequest, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/profile") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("\(token)", forHTTPHeaderField: "X-Auth-token")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(user))
        }
        task.resume()
    }
    
    func loadTreks(token: String, completion: @escaping (Result<Treks, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/trek") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(token)", forHTTPHeaderField: "X-Auth-token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
//                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode([Trek].self, from: data)
                
                let treks: Treks = .init(treks: result)
                
                completion(.success(treks))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()

    }
    
    
    func changeProfileImage(with userImage: UserImage, token: String, completion: @escaping (Result<UserImage, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/profile/avatar") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("\(token)", forHTTPHeaderField: "X-Auth-token")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(userImage)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                var userProfile: UserImage = UserImage(img: "", id: 0)
                let result = try decoder.decode(UserImage.self, from: data)
                userProfile.img = result.img
                userProfile.id = result.id
                completion(.success(userProfile))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func checkAuth(with user: UserCheckAuthRequest, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/profile/\(user.id)") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(user.authToken)", forHTTPHeaderField: "X-Auth-token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                var userProfile: UserProfile = UserProfile(id: 0, email: "", nickname: "", img: "", authToken: "", treksNumber: 0)
//                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode(UserProfile.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func regUser(with user: UserCreateRequest, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/profile") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                var userProfile: UserProfile = UserProfile(id: 0, email: "", nickname: "", img: "", authToken: "", treksNumber: 0)
//                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode(UserCreateResponse.self, from: data)
                userProfile.nickname = user.nickname
                userProfile.email = user.email
                userProfile.nickname = user.nickname
                userProfile.authToken = result.authToken
                userProfile.id = result.id
                completion(.success(userProfile))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func authUser(with user: UserAuth, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "https://findfreelancer.ru/api/v1/login") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
//                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode(UserProfile.self, from: data)
                
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
    
