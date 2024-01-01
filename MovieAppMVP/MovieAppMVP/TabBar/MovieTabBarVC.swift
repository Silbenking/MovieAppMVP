//
//  MovieTabBarVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

class MovieTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        tabBarApperiance()
    }
    
    private func generateTabBar() {
        
        let topChartVC = UINavigationController(rootViewController: TopChartAssemble.assemble())
        topChartVC.navigationBar.barTintColor = .black
        topChartVC.navigationBar.backgroundColor = .black
        topChartVC.navigationBar.tintColor = .orange.withAlphaComponent(0.8)
        
        let savedVC = UINavigationController(rootViewController: SavedFilmsAssemble.assemble())
        viewControllers = [generateVC(viewController: topChartVC, title: "Топ", image: UIImage(systemName: "house.fill")),
                           generateVC(viewController: savedVC, title: "Избранное", image: UIImage(systemName: "heart.fill"))]

    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
        
    }
    
    private func tabBarApperiance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height),
                                      cornerRadius: height/2 )
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .orange.withAlphaComponent(0.5)
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = false
    }

}
