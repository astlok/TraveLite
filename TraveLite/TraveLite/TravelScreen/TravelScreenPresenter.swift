//
//  TravelScreenPresenter.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import Foundation

final class TravelScreenPresenter {
	weak var view: TravelScreenViewInput?
    weak var moduleOutput: TravelScreenModuleOutput?

	private let router: TravelScreenRouterInput
	private let interactor: TravelScreenInteractorInput

    init(router: TravelScreenRouterInput, interactor: TravelScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TravelScreenPresenter: TravelScreenModuleInput {
}

extension TravelScreenPresenter: TravelScreenViewOutput {
    func didSubmit(trek: TrekCreateRequest) {
        print("Отправка")
    }
    
}

extension TravelScreenPresenter: TravelScreenInteractorOutput {
}
