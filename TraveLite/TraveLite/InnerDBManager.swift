//
//  TokenManager.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 28/11/21.
//

import Foundation

final class InnerDBManager {
    
    private enum DBKeys: String {
        case token
    }
    
    
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: DBKeys.token.rawValue)
        }
        
        set {
            UserDefaults.standard.set(newValue ?? "", forKey: DBKeys.token.rawValue)
        }
    }
}
