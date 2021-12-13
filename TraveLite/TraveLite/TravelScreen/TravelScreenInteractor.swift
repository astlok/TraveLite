//
//  TravelScreenInteractor.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import Foundation

final class TravelScreenInteractor {
	weak var output: TravelScreenInteractorOutput?
    
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

extension TravelScreenInteractor: TravelScreenInteractorInput {
    func didCreateTrek(trek: TrekCreateRequest) {
        apiManager.createTrek(trek: trek, token: InnerDBManager.authToken ?? "", completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let trek = Trek.init(id: response.id, name: response.name, difficult: response.difficult, days: response.days, things: nil, description: response.description, file: response.file, region: response.region, rating: 0, userID: response.userID)
                    output?.didCreate(with: trek)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
    
}
