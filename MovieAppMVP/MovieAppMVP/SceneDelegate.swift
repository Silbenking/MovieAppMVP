//
//  SceneDelegate.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
      
//        let topChartVC = UINavigationController(rootViewController: TopChartAssemble.assemble())
//        
//       
//        topChartVC.tabBarItem = UITabBarItem(title: "", image: .init(systemName: "house"), selectedImage: .init(systemName: "house.fill"))
//        
//        let savedVC = UINavigationController(rootViewController: SavedFilmsAssemble.assemble())
//        savedVC.tabBarItem = UITabBarItem(title: "", image: .init(systemName: "heart"), selectedImage: .init(systemName: "heart.fill"))
//        
//        let tabBar = UITabBarController()
//        tabBar.viewControllers = [topChartVC, savedVC]
//        tabBar.tabBar.tintColor = .red
//        tabBar.tabBar.backgroundColor = .clear
        
        window?.rootViewController = MovieTabBarVC()
        window?.makeKeyAndVisible()
    }
}
