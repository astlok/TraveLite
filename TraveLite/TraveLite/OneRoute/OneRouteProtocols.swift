//
//  OneRouteProtocols.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.12.2021.
//  
//

import Foundation

protocol OneRouteModuleInput {
	var moduleOutput: OneRouteModuleOutput? { get }
}

protocol OneRouteModuleOutput: class {
}

protocol OneRouteViewInput: class {
}

protocol OneRouteViewOutput: class {
}

protocol OneRouteInteractorInput: class {
}

protocol OneRouteInteractorOutput: class {
}

protocol OneRouteRouterInput: class {
}
