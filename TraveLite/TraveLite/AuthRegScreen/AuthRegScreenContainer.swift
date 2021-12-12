import UIKit

final class AuthRegScreenContainer {
    let input: AuthRegScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: AuthRegScreenRouterInput!

	class func assemble(with context: AuthRegScreenContext) -> AuthRegScreenContainer {
        let router = AuthRegScreenRouter()
        let interactor = AuthRegScreenInteractor()
        let presenter = AuthRegScreenPresenter(router: router, interactor: interactor)
		let viewController = AuthRegScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
    
        router.sourceViewController = viewController

        return AuthRegScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AuthRegScreenModuleInput, router: AuthRegScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AuthRegScreenContext {
	weak var moduleOutput: AuthRegScreenModuleOutput?
}
