//
//  TabBarControllProtocols.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 24/11/21.
//  
//

import Foundation

protocol TabBarControllModuleInput {
	var moduleOutput: TabBarControllModuleOutput? { get }
}

protocol TabBarControllModuleOutput: AnyObject {
}

protocol TabBarControllViewInput: AnyObject {
}

protocol TabBarControllViewOutput: AnyObject {
//    func didLoadView()
}

protocol TabBarControllInteractorInput: AnyObject {
}

protocol TabBarControllInteractorOutput: AnyObject {
}

protocol TabBarControllRouterInput: AnyObject {
}
