import UIKit

final class AuthScreenContainer {
    let input: AuthScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: AuthScreenRouterInput!

	class func assemble(with context: AuthScreenContext) -> AuthScreenContainer {
        let router = AuthScreenRouter()
        let interactor = AuthScreenInteractor()
        let presenter = AuthScreenPresenter(router: router, interactor: interactor)
		let viewController = AuthScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.sourceViewController = viewController

		interactor.output = presenter

        return AuthScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AuthScreenModuleInput, router: AuthScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AuthScreenContext {
	weak var moduleOutput: AuthScreenModuleOutput?
}
