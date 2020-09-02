//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = scene as? UIWindowScene else { return }
    
    window = UIWindow(windowScene: scene)
    
    let root = UINavigationController(rootViewController: MainTabBarController())
    root.navigationBar.backgroundColor = .white
    
    window?.rootViewController = root
    window?.makeKeyAndVisible()
    
    let nvc = UINavigationBar.appearance()
    nvc.barTintColor = .red
    nvc.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
  }


}

