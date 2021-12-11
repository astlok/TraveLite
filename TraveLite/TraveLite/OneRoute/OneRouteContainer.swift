//
//  OneRouteContainer.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.12.2021.
//  
//

import UIKit

final class OneRouteContainer {
    let input: OneRouteModuleInput
	let viewController: UIViewController
	private(set) weak var router: OneRouteRouterInput!

	class func assemble(with context: OneRouteContext) -> OneRouteContainer {
        let router = OneRouteRouter()
        let interactor = OneRouteInteractor()
        let presenter = OneRoutePresenter(router: router, interactor: interactor)
        let viewController = OneRouteViewController(output: presenter, trek: context.trek)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return OneRouteContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: OneRouteModuleInput, router: OneRouteRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct OneRouteContext {
    var trek: Trek
    
	weak var moduleOutput: OneRouteModuleOutput?
}
