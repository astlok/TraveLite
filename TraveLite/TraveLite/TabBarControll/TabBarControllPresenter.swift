//
//  TabBarControllPresenter.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 24/11/21.
//  
//

import Foundation

final class TabBarControllPresenter {
	weak var view: TabBarControllViewInput?
    weak var moduleOutput: TabBarControllModuleOutput?

	private let router: TabBarControllRouterInput
	private let interactor: TabBarControllInteractorInput

    init(router: TabBarControllRouterInput, interactor: TabBarControllInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TabBarControllPresenter: TabBarControllModuleInput {
}

extension TabBarControllPresenter: TabBarControllViewOutput {
}

extension TabBarControllPresenter: TabBarControllInteractorOutput {
}
