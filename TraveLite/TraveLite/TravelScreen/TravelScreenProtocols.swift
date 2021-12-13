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

protocol TravelScreenModuleOutput: AnyObject {
}

protocol TravelScreenViewInput: AnyObject {
}

protocol TravelScreenViewOutput: AnyObject {
    func didSubmit(trek: TrekCreateRequest)
}

protocol TravelScreenInteractorInput: AnyObject {
    func didCreateTrek(trek: TrekCreateRequest)
}

protocol TravelScreenInteractorOutput: AnyObject {
    func didCreate(with trek: Trek)
    
    func didFail(with error: Error)
}

protocol TravelScreenRouterInput: AnyObject {
    func showTreks()

    func showError(with text: String)
}
