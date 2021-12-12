//
//  TravelScreenProtocols.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import Foundation

protocol TravelScreenModuleInput {
	var moduleOutput: TravelScreenModuleOutput? { get }
}

protocol TravelScreenModuleOutput: class {
}

protocol TravelScreenViewInput: class {
}

protocol TravelScreenViewOutput: class {
    func didSubmit(trek: TrekCreateRequest)
}

protocol TravelScreenInteractorInput: class {
}

protocol TravelScreenInteractorOutput: class {
}

protocol TravelScreenRouterInput: class {
}
