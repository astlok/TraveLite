//
//  TreksScreenProtocols.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import Foundation

protocol TreksScreenModuleInput {
	var moduleOutput: TreksScreenModuleOutput? { get }
}

protocol TreksScreenModuleOutput: AnyObject {
}

protocol TreksScreenViewInput: AnyObject {
    func reloadData()
}

protocol TreksScreenViewOutput: AnyObject {
    var itemsCount: Int { get }
    
    func item(at index: Int) -> TrekCellModell
    
    func didLoadView()
    
    func didPullToRefresh()
    
    func didSelectItem(at index: Int)
}

protocol TreksScreenInteractorInput: AnyObject {
    func loadTreks()
}

protocol TreksScreenInteractorOutput: AnyObject {
    func didFail(with error: Error)
    
    func treaksLoad(with treks: Treks)
}

protocol TreksScreenRouterInput: AnyObject {
    func showError(with error: String)
    
    func showTrek(with trek: TrekCellModell)
}
