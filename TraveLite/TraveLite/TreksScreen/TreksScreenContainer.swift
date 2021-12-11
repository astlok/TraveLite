//
//  TreksScreenContainer.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import UIKit

final class TreksScreenContainer {
    let input: TreksScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: TreksScreenRouterInput!

	class func assemble(with context: TreksScreenContext) -> TreksScreenContainer {
        let router = TreksScreenRouter()
        let interactor = TreksScreenInteractor()
        let presenter = TreksScreenPresenter(router: router, interactor: interactor)
		let viewController = TreksScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        
        router.sourceViewController = viewController

		interactor.output = presenter

        return TreksScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TreksScreenModuleInput, router: TreksScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TreksScreenContext {
	weak var moduleOutput: TreksScreenModuleOutput?
}
