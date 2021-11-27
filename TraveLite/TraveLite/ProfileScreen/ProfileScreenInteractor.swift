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
    func changeProfileImage(image: UIImage, id: UInt64) {
        let binaryImage = image.pngData()! as NSData
        let base64 = binaryImage.base64EncodedData(options: .lineLength64Characters)
        let str = String(decoding: base64, as: UTF8.self)
        let userImage = UserImage(image: str, id: id)
        apiManager.changeProfileImage(with: userImage, completion: { [weak output] result in
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
