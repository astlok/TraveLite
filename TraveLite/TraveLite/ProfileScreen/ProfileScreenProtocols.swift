//
//  ProfileScreenProtocols.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import Foundation
import UIKit

protocol ProfileScreenModuleInput {
	var moduleOutput: ProfileScreenModuleOutput? { get }
}

protocol ProfileScreenModuleOutput: AnyObject {
}

protocol ProfileScreenViewInput: AnyObject {
    func displayImage(image: String)
    func displayChangesProfile(user: UserCreateRequest)
}

protocol ProfileScreenViewOutput: AnyObject {
    func didSelectedProfileImage(image: UIImage, id: UInt64, token: String)
    func didChange(user: UserCreateRequest, token: String)
}

protocol ProfileScreenInteractorInput: AnyObject {
    func changeProfileImage(image: UIImage, id: UInt64, token: String)
    func changeProfile(user: UserCreateRequest, token: String)
}

protocol ProfileScreenInteractorOutput: AnyObject {
    func didChangeImage(with user: UserImage)
    func didChangeProfile(with user: UserCreateRequest)
    func didFail(with error: Error)
}

protocol ProfileScreenRouterInput: AnyObject {
    func showError(with text: String)
}
