import Foundation

protocol RegScreenModuleInput {
	var moduleOutput: RegScreenModuleOutput? { get }
}

protocol RegScreenModuleOutput: AnyObject {
}

protocol RegScreenViewInput: AnyObject {
}

protocol RegScreenViewOutput: AnyObject {
    func didTapSubmitButton(with user: UserCreateRequest)
}

protocol RegScreenInteractorInput: AnyObject {
    func regUser(with user: UserCreateRequest)
}

protocol RegScreenInteractorOutput: AnyObject {
    func didReg(with user: UserProfile)
    
    func didFail(with error: Error)
}

protocol RegScreenRouterInput: AnyObject {
    func showProfile(with user: UserProfile)
    
    func showError(with text: String)
}
