//
//  TreksScreenInteractor.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import Foundation

final class TreksScreenInteractor {
	weak var output: TreksScreenInteractorOutput?
    
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

extension TreksScreenInteractor: TreksScreenInteractorInput {
    func loadTreks() {
        
        apiManager.loadTreks(token: InnerDBManager.authToken ?? "", completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.treaksLoad(with: response)
                    
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
    
}
