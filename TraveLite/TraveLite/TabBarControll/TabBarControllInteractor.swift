//
//  TabBarControllInteractor.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 24/11/21.
//  
//

import Foundation

final class TabBarControllInteractor {
	weak var output: TabBarControllInteractorOutput?
    
    weak var sourceViewController: ViewController?
}

extension TabBarControllInteractor: TabBarControllInteractorInput {
}
