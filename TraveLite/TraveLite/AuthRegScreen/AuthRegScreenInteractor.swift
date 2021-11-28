import Foundation



final class AuthRegScreenInteractor {
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
	weak var output: AuthRegScreenInteractorOutput?
}

extension AuthRegScreenInteractor: AuthRegScreenInteractorInput {
    func regUser(with user: UserCreateRequest) {
        apiManager.regUser(with: user, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didReg(with: response)
                    InnerDBManager.authToken = response.authToken
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
    
    func getUser(with user: UserAuth) {
        apiManager.authUser(with: user, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didAuth(with: response)
                    InnerDBManager.authToken = response.authToken
                case .failure(let error):
                    output?.didFail(with: error)
                        
                }
            }
        })
    }
}
