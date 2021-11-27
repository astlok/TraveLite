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
        var context = TabBarControllContext(moduleOutput: nil)
        context.user = user
        let container = TabBarControllContainer.assemble(with: context)
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
