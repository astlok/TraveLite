//
//  ProfileScreenRouter.swift
//  TraveLite
//
//  Created by Yaroslav Belykh on 16.11.2021.
//  
//

import UIKit

final class ProfileScreenRouter {
    weak var sourceViewController: UIViewController?
}

extension ProfileScreenRouter: ProfileScreenRouterInput {
    func showTrek(with trek: Trek) {
        var context = OneRouteContext(moduleOutput: nil)
        context.trek = trek
        let container = OneRouteContainer.assemble(with: context)
        
        sourceViewController?.present(container.viewController, animated: true, completion: nil)
    }
    
    func showAuth() {
        let container = AuthRegScreenContainer.assemble(with: .init())
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let vc = container.viewController
        window.rootViewController = vc
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3

        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }
    
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        
        sourceViewController?.present(alertController, animated: true, completion: nil)
    }
}
