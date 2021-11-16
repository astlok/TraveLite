import Foundation

final class AuthScreenInteractor {
	weak var output: AuthScreenInteractorOutput?
    
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

extension AuthScreenInteractor: AuthScreenInteractorInput {
    func getUser(with user: UserAuth) {
        apiManager.authUser(with: user, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didAuth(with: response)
                case .failure(let error):
                    output?.didFail(with: error)
                        
                }
            }
        })
    }
    
}
