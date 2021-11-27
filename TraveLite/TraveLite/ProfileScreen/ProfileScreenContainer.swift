//
//  ProfileScreenContainer.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import UIKit

final class ProfileScreenContainer {
    let input: ProfileScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProfileScreenRouterInput!

	class func assemble(with context: ProfileScreenContext) -> ProfileScreenContainer {
        let router = ProfileScreenRouter()
        let interactor = ProfileScreenInteractor()
        let presenter = ProfileScreenPresenter(router: router, interactor: interactor)
        let viewController = ProfileScreenViewController(output: presenter, user: context.user)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        return ProfileScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProfileScreenModuleInput, router: ProfileScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProfileScreenContext {
    var user: UserProfile?
	weak var moduleOutput: ProfileScreenModuleOutput?
}
