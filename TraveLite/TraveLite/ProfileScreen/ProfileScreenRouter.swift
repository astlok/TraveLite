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
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        
        sourceViewController?.present(alertController, animated: true, completion: nil)
    }
}
