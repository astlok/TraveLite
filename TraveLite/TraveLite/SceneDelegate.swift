//
//  SceneDelegate.swift
//  TraveLite
//
//  Created by Олег Реуцкий on 16/11/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        
//        let container = TravelScreenContainer.assemble(with: .init())
//        let viewController = container.viewController
//
//        window.rootViewController = viewController
//        self.window = window
//        window.makeKeyAndVisible()

//
//        checkAuth(show: { user, isAuth in
//            if !isAuth {
//                let container = AuthRegScreenContainer.assemble(with: .init())
//
//                let viewController = container.viewController
//                
//
//                window.rootViewController = viewController
//                self.window = window
//                window.makeKeyAndVisible()
//            } else {
//                var context = TabBarControllContext(moduleOutput: nil)
//                context.user = user
//                let container = TabBarControllContainer.assemble(with: context)
//                
//                let viewController = container.viewController
//                
//                window.rootViewController = viewController
//                self.window = window
//                window.makeKeyAndVisible()
//            }
//        })

    }
    
    
    func checkAuth(show: @escaping (UserProfile, Bool) -> Void) {
        let apiManager = ApiManager.shared
        var user = UserProfile.init(id: 0, email: "", nickname: "", img: "", authToken: "", treksNumber: 0)
        let authUser = UserCheckAuthRequest.init(authToken: InnerDBManager.authToken ?? "", id: InnerDBManager.userID ?? 0)
        apiManager.checkAuth(with: authUser, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    user.id = response.id
                    user.email = response.email
                    user.nickname = response.nickname
                    user.img = response.img
                    user.authToken = response.authToken
                    user.treksNumber = response.treksNumber
                    show(user, true)
                case .failure(let error):
                    let errorCode = (error as NSError).code
                    if errorCode == 4864 {
                        show(user, false)
                    }
                }
            }
        })

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

