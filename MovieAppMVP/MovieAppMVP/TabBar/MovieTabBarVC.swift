//
//  MovieTabBarVC.swift
//  MovieAppMVP
//
//

import UIKit

final class MovieTabBarVC: UITabBarController {

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
        savedVC.navigationBar.barTintColor = .black
        savedVC.navigationBar.backgroundColor = .black
        savedVC.navigationBar.tintColor = .orange.withAlphaComponent(0.8)

        let searchFilmVC = UINavigationController(rootViewController: SearchFilmAssemble.assemble())
        searchFilmVC.navigationBar.barTintColor = .black
        searchFilmVC.navigationBar.backgroundColor = .black
        searchFilmVC.navigationBar.tintColor = .orange.withAlphaComponent(0.8)

        viewControllers = [generateVCWithItem(viewController: topChartVC, tabBarItem: TabBarItem.topItem),
                           generateVCWithItem(viewController: savedVC, tabBarItem: TabBarItem.favoriteItem),
                           generateVCWithItem(viewController: searchFilmVC, tabBarItem: TabBarItem.searchItem)]

    }

    private func generateVCWithItem(viewController: UIViewController, tabBarItem: TabBarItem.Asset) -> UIViewController {
        viewController.tabBarItem.title = tabBarItem.title
        viewController.tabBarItem.image = tabBarItem.image
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

private enum TabBarItem {
    struct Asset {
        let title: String
        let image: UIImage?
    }

    static let topItem = Asset(title: "Топ", image: UIImage(systemName: "house.fill"))
    static let favoriteItem = Asset(title: "Избранное", image: UIImage(systemName: "heart.fill"))
    static let searchItem = Asset(title: "Поиск", image: UIImage(systemName: "magnifyingglass.circle"))

}
