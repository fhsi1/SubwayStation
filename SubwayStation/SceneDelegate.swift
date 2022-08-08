//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by Yujean Cho on 2022/08/08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // ViewController Base
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}

