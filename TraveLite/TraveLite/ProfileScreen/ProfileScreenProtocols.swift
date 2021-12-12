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
    
    func reloadData()
}

protocol ProfileScreenViewOutput: AnyObject {
    func didSelectedProfileImage(image: UIImage, id: Int)
    
    func didChange(user: UserCreateRequest)
  
    func didExit()
    
    var itemsCount: Int { get }
    
    func item(at index: Int) -> Trek
    
    func didLoadView()
    
    func didPullToRefresh()
    
    func didSelectItem(at index: Int)
}

protocol ProfileScreenInteractorInput: AnyObject {
    func changeProfileImage(image: UIImage, id: Int)
    
    func changeProfile(user: UserCreateRequest)
  
    func exit()
    
    func loadTreks()
}

protocol ProfileScreenInteractorOutput: AnyObject {
    func didChangeImage(with user: UserImage)
    
    func didChangeProfile(with user: UserCreateRequest)

    func didExitFromProfile()

    func didFail(with error: Error)
    
    func treaksLoad(with treks: Treks)
}

protocol ProfileScreenRouterInput: AnyObject {
    func showAuth()
    func showError(with text: String)
    
    func showTrek(with trek: Trek)
}
