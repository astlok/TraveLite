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

    init(router: ProfileScreenRouterInput, interactor: ProfileScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfileScreenPresenter: ProfileScreenModuleInput {
}

extension ProfileScreenPresenter: ProfileScreenViewOutput {    
    func didSelectedProfileImage(image: UIImage, id: UInt64) {
        interactor.changeProfileImage(image: image, id: id)
    }
}

extension ProfileScreenPresenter: ProfileScreenInteractorOutput {
    func didChangeImage(with user: UserImage) {
        view?.displayImage(image: user.image)
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
}
