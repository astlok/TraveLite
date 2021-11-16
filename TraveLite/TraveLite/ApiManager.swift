import Foundation

enum NetworkError: Error{
    case unexpected
}

protocol ApiManagerDescription {
    func regUser(with user: UserCreateRequest, completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func authUser(with user: UserAuth, completion: @escaping (Result<UserProfile, Error>) -> Void)
}

final class ApiManager: ApiManagerDescription {
    
    static let shared: ApiManagerDescription = ApiManager()
    
    private init() {}

    
    func regUser(with user: UserCreateRequest, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/api/v1/profile") else {
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
        guard let url = URL(string: "http://127.0.0.1:8080/api/v1/login") else {
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
                print(try? JSONSerialization.jsonObject(with: data, options: []))
                let result = try decoder.decode(UserProfile.self, from: data)
                
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
    
