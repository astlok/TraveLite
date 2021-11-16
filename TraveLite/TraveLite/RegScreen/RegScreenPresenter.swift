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
    func didTapSubmitButton(with user: UserCreateRequest) {
        self.interactor.regUser(with: user)
    }
}

extension RegScreenPresenter: RegScreenInteractorOutput {
    func didReg(with user: UserProfile) {
        router.showProfile(with: user)
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
}
