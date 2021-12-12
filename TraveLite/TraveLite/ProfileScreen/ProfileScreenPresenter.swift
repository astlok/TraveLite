//
//  ProfileScreenPresenter.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import Foundation
import UIKit

final class ProfileScreenPresenter {
	weak var view: ProfileScreenViewInput?
    weak var moduleOutput: ProfileScreenModuleOutput?

	private let router: ProfileScreenRouterInput
	private let interactor: ProfileScreenInteractorInput
    
    private var treksModels: [Trek] = []

    init(router: ProfileScreenRouterInput, interactor: ProfileScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfileScreenPresenter: ProfileScreenModuleInput {
}

extension ProfileScreenPresenter: ProfileScreenViewOutput {
    func didExit() {
        interactor.exit()
    }
    func didSelectItem(at index: Int) {
        router.showTrek(with: treksModels[index])
    }
    
    func didChange(user: UserCreateRequest) {
        interactor.changeProfile(user: user)
    }
    
    func didSelectedProfileImage(image: UIImage, id: Int) {
        interactor.changeProfileImage(image: image, id: id)
    }
    
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

extension ProfileScreenPresenter: ProfileScreenInteractorOutput {
    func didExitFromProfile() {
        router.showAuth()
    }
  
    func treaksLoad(with treks: Treks) {
        for trek in treks.treks {
            if treksModels.isEmpty && trek.userID == InnerDBManager.userID {
                treksModels.append(trek)
            }
            if !treksModels.contains(where: {$0.id == trek.id}) && trek.userID == InnerDBManager.userID {
                treksModels.append(trek)
            }
        }
        view?.reloadData()
    }
    
    func didChangeProfile(with user: UserCreateRequest) {
        view?.displayChangesProfile(user: user)
    }
    
    func didChangeImage(with user: UserImage) {
        view?.displayImage(image: user.img)
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
}
