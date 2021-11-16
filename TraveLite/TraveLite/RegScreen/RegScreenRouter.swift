import UIKit

final class RegScreenRouter {
    weak var sourceViewController: UIViewController?
}

extension RegScreenRouter: RegScreenRouterInput {
    func showProfile(with user: UserProfile) {
        print(user)
    }
    
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        
        sourceViewController?.present(alertController, animated: true, completion: nil)
    }
}
