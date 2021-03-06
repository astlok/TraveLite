//
//  TreksScreenRouter.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 3/12/21.
//  
//

import UIKit

final class TreksScreenRouter {
    weak var sourceViewController: UIViewController?
}

extension TreksScreenRouter: TreksScreenRouterInput {
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
