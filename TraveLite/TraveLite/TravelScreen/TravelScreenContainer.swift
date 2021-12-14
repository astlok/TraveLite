//
//  TravelScreenContainer.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import UIKit

final class TravelScreenContainer {
    let input: TravelScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: TravelScreenRouterInput!

	class func assemble(with context: TravelScreenContext) -> TravelScreenContainer {
        let router = TravelScreenRouter()
        let interactor = TravelScreenInteractor()
        let presenter = TravelScreenPresenter(router: router, interactor: interactor)
		let viewController = TravelScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.sourceViewController = viewController

        return TravelScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TravelScreenModuleInput, router: TravelScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TravelScreenContext {
	weak var moduleOutput: TravelScreenModuleOutput?
}
