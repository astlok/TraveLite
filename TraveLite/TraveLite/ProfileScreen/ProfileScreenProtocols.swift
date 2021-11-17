//
//  ProfileScreenProtocols.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import Foundation

protocol ProfileScreenModuleInput {
	var moduleOutput: ProfileScreenModuleOutput? { get }
}

protocol ProfileScreenModuleOutput: AnyObject {
}

protocol ProfileScreenViewInput: AnyObject {
}

protocol ProfileScreenViewOutput: AnyObject {
}

protocol ProfileScreenInteractorInput: AnyObject {
}

protocol ProfileScreenInteractorOutput: AnyObject {
}

protocol ProfileScreenRouterInput: AnyObject {
}
