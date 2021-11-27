import Foundation

final class RegScreenPresenter {
	weak var view: RegScreenViewInput?
    weak var moduleOutput: RegScreenModuleOutput?

	private let router: RegScreenRouterInput
	private let interactor: RegScreenInteractorInput

    init(router: RegScreenRouterInput, interactor: RegScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegScreenPresenter: RegScreenModuleInput {
}

extension RegScreenPresenter: RegScreenViewOutput {
    func didTapAuthSubmitButton(with user: UserAuth) {
        self.interactor.getUser(with: user)
    }
    
    func didTapRegSubmitButton(with user: UserCreateRequest) {
        self.interactor.regUser(with: user)
    }
}

extension RegScreenPresenter: RegScreenInteractorOutput {
    func didReg(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didAuth(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
}
