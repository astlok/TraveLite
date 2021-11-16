import Foundation



final class RegScreenInteractor {
    private let apiManager: ApiManagerDescription
    
    init(apiManager: ApiManagerDescription = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
	weak var output: RegScreenInteractorOutput?
}

extension RegScreenInteractor: RegScreenInteractorInput {
    func regUser(with user: UserCreateRequest) {
        apiManager.regUser(with: user, completion: { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didReg(with: response)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        })
    }
}
