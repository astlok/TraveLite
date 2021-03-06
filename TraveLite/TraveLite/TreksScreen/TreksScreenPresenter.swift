//
//  TreksScreenPresenter.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import Foundation

final class TreksScreenPresenter {
	weak var view: TreksScreenViewInput?
    weak var moduleOutput: TreksScreenModuleOutput?

	private let router: TreksScreenRouterInput
	private let interactor: TreksScreenInteractorInput
    
    private var treksModels: [Trek] = []

    init(router: TreksScreenRouterInput, interactor: TreksScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    deinit {
        print("KEK")
    }
}

extension TreksScreenPresenter: TreksScreenModuleInput {
}

extension TreksScreenPresenter: TreksScreenViewOutput {
    func didPullToRefresh() {
        interactor.loadTreks()
    }
    
    func didLoadView() {
        interactor.loadTreks()
    }
    
    var itemsCount: Int {
        return treksModels.count
    }
    
    func item(at index: Int) -> Trek {
        return treksModels[index]
    }
}

extension TreksScreenPresenter: TreksScreenInteractorOutput {
    func didSelectItem(at index: Int) {
        router.showTrek(with: treksModels[index])
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
    
    func treaksLoad(with treks: Treks) {
        for trek in treks.treks {
            if treksModels.isEmpty {
                treksModels.append(trek)
            }
            if !treksModels.contains(where: {$0.id == trek.id}) {
                treksModels.append(trek)
            }
        }
        view?.reloadData()
    }
    
}
