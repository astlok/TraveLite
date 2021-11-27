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
}

protocol ProfileScreenViewOutput: AnyObject {
    func didSelectedProfileImage(image: UIImage, id: UInt64)
}

protocol ProfileScreenInteractorInput: AnyObject {
    func changeProfileImage(image: UIImage, id: UInt64)
}

protocol ProfileScreenInteractorOutput: AnyObject {
    func didChangeImage(with user: UserImage)
    
    func didFail(with error: Error)
}

protocol ProfileScreenRouterInput: AnyObject {
    func showError(with text: String)
}
