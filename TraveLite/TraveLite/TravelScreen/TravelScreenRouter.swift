//
//  TravelScreenRouter.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 26.11.2021.
//  
//

import UIKit

final class TravelScreenRouter {
    weak var sourceViewController: UIViewController?
}

extension TravelScreenRouter: TravelScreenRouterInput {
    func showTrek(with trek: Trek) {
        var context = OneRouteContext(moduleOutput: nil)
        context.trek = trek
        let container = OneRouteContainer.assemble(with: context)
        
        sourceViewController?.present(container.viewController, animated: true, completion: nil)
    }
    
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        
        sourceViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
