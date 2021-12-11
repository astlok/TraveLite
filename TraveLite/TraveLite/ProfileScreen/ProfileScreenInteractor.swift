//
//  ProfileScreenInteractor.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import Foundation
import UIKit

final class ProfileScreenInteractor {
	weak var output: ProfileScreenInteractorOutput?
    
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

extension ProfileScreenInteractor: ProfileScreenInteractorInput {
    func exit() {
        print("Выход из профиля")
        
        let token = InnerDBManager.authToken ?? ""
        
        apiManager.exit(token: token, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Успешный выход")
                    InnerDBManager.authToken = ""
                    output?.didExitFromProfile()
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
    
    func changeProfile(user: UserCreateRequest) {
        print("Изменение профиля", user.nickname, user.password)
        
        let token = InnerDBManager.authToken ?? ""
        
        apiManager.changeProfile(with: user, token: token, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didChangeProfile(with: response)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
    
    func changeProfileImage(image: UIImage, id: UInt64) {
        print("Изменение изображения")
        let binaryImage = image.pngData()! as NSData
        let base64 = binaryImage.base64EncodedData(options: .lineLength64Characters)
        let str = String(decoding: base64, as: UTF8.self)
        let userImage = UserImage(img: str, id: id)
        
        let token = InnerDBManager.authToken ?? ""
        
        apiManager.changeProfileImage(with: userImage, token: token, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didChangeImage(with: response)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
}
