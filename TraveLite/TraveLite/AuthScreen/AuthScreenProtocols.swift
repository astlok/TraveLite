import Foundation

protocol AuthScreenModuleInput {
	var moduleOutput: AuthScreenModuleOutput? { get }
}

protocol AuthScreenModuleOutput: AnyObject {
}

protocol AuthScreenViewInput: AnyObject {
}

protocol AuthScreenViewOutput: AnyObject {
    func didTapRegButton()
    
    func didTapSubmitButton(with user: UserAuth)
}

protocol AuthScreenInteractorInput: AnyObject {
    func getUser(with user: UserAuth)
}

protocol AuthScreenInteractorOutput: AnyObject {
    func didAuth(with user: UserProfile)
    
    func didFail(with error: Error)
}

protocol AuthScreenRouterInput: AnyObject {
    func showProfile(with user: UserProfile)
    
    func showRegScreen()
    
    func showError(with text: String)
}
