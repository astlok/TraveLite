import UIKit

final class AuthScreenRouter {
    weak var sourceViewController: UIViewController?
}

extension AuthScreenRouter: AuthScreenRouterInput {
    func showRegScreen() {
        let container = RegScreenContainer.assemble(with: .init())
        sourceViewController?.present(container.viewController, animated: true, completion: nil)
    }
    
    func showProfile(with user: UserProfile) {
        print(user)
    }
    
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        
        sourceViewController?.present(alertController, animated: true, completion: nil)
    }
}
