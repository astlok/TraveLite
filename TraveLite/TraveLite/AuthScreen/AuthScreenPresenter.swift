import Foundation

final class AuthScreenPresenter {
	weak var view: AuthScreenViewInput?
    weak var moduleOutput: AuthScreenModuleOutput?

	private let router: AuthScreenRouterInput
	private let interactor: AuthScreenInteractorInput

    init(router: AuthScreenRouterInput, interactor: AuthScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthScreenPresenter: AuthScreenModuleInput {
}

extension AuthScreenPresenter: AuthScreenViewOutput {
    func didTapSubmitButton(with user: UserAuth) {
        interactor.getUser(with: user)
    }
    
    func didTapRegButton() {
        router.showRegScreen()
    }
}

extension AuthScreenPresenter: AuthScreenInteractorOutput {
    func didAuth(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
    
}
