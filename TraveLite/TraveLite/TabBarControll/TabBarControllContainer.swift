//
//  TabBarControllContainer.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 24/11/21.
//  
//

import UIKit

final class TabBarControllContainer {
    let input: TabBarControllModuleInput
	let viewController: UIViewController
	private(set) weak var router: TabBarControllRouterInput!

	class func assemble(with context: TabBarControllContext) -> TabBarControllContainer {
        let router = TabBarControllRouter()
        let interactor = TabBarControllInteractor()
        let presenter = TabBarControllPresenter(router: router, interactor: interactor)
        
        
        var profileContext = ProfileScreenContext(user: nil, moduleOutput: nil)
        profileContext.user = context.user
        let profileContainer = ProfileScreenContainer.assemble(with: profileContext)
        
        //TODO: Заглушки для создания заказа и списка всех заказов
        var profileContext2 = ProfileScreenContext(user: nil, moduleOutput: nil)
        profileContext2.user = context.user
        let profileContainer2 = ProfileScreenContainer.assemble(with: profileContext2)
       
        
        var profileContext3 = ProfileScreenContext(user: nil, moduleOutput: nil)
        profileContext3.user = context.user
        let profileContainer3 = ProfileScreenContainer.assemble(with: profileContext3)
       
        //TODO: Вот по сюда заглушка
        
        let viewController = TabBarControllViewController(output: presenter)
        
        viewController.setViewControllers( [ profileContainer2.viewController, profileContainer3.viewController, profileContainer.viewController], animated: true)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TabBarControllContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TabBarControllModuleInput, router: TabBarControllRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TabBarControllContext {
    var user: UserProfile?
    
	weak var moduleOutput: TabBarControllModuleOutput?
}
