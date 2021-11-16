import UIKit

final class RegScreenContainer {
    let input: RegScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: RegScreenRouterInput!

	class func assemble(with context: RegScreenContext) -> RegScreenContainer {
        let router = RegScreenRouter()
        let interactor = RegScreenInteractor()
        let presenter = RegScreenPresenter(router: router, interactor: interactor)
		let viewController = RegScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
    
        router.sourceViewController = viewController

        return RegScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: RegScreenModuleInput, router: RegScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct RegScreenContext {
	weak var moduleOutput: RegScreenModuleOutput?
}
