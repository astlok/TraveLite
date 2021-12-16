import Foundation

final class AuthRegScreenPresenter {
	weak var view: AuthRegScreenViewInput?
    weak var moduleOutput: AuthRegScreenModuleOutput?

	private let router: AuthRegScreenRouterInput
	private let interactor: AuthRegScreenInteractorInput

    init(router: AuthRegScreenRouterInput, interactor: AuthRegScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthRegScreenPresenter: AuthRegScreenModuleInput {
}

extension AuthRegScreenPresenter: AuthRegScreenViewOutput {
    func didTapAuthSubmitButton(with user: UserAuth) {
        self.interactor.getUser(with: user)
    }
    
    func didTapRegSubmitButton(with user: UserCreateRequest) {
        self.interactor.regUser(with: user)
    }
}

extension AuthRegScreenPresenter: AuthRegScreenInteractorOutput {
    func didReg(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didAuth(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didFail(with error: Error) {
        router.showError(with: "Неверные имейл или пароль")
    }
}
