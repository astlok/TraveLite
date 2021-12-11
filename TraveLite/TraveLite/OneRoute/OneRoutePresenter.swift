//
//  OneRoutePresenter.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.12.2021.
//  
//

import Foundation

final class OneRoutePresenter {
	weak var view: OneRouteViewInput?
    weak var moduleOutput: OneRouteModuleOutput?

	private let router: OneRouteRouterInput
	private let interactor: OneRouteInteractorInput

    init(router: OneRouteRouterInput, interactor: OneRouteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OneRoutePresenter: OneRouteModuleInput {
}

extension OneRoutePresenter: OneRouteViewOutput {
}

extension OneRoutePresenter: OneRouteInteractorOutput {
}
