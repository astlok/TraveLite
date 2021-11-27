import Foundation

protocol AuthRegScreenModuleInput {
	var moduleOutput: AuthRegScreenModuleOutput? { get }
}

protocol AuthRegScreenModuleOutput: AnyObject {
}

protocol AuthRegScreenViewInput: AnyObject {
}

protocol AuthRegScreenViewOutput: AnyObject {
    func didTapRegSubmitButton(with user: UserCreateRequest)
    
    func didTapAuthSubmitButton(with user: UserAuth)
}

protocol AuthRegScreenInteractorInput: AnyObject {
    func regUser(with user: UserCreateRequest)
    
    func getUser(with user: UserAuth)
}

protocol AuthRegScreenInteractorOutput: AnyObject {
    func didReg(with user: UserProfile)
    
    func didAuth(with user: UserProfile)
    
    func didFail(with error: Error)
}

protocol AuthRegScreenRouterInput: AnyObject {
    func showProfile(with user: UserProfile)
    
    func showError(with text: String)
}
