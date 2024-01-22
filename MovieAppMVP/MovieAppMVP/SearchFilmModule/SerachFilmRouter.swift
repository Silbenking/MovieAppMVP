//
//  SerachFilmRouter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 22.01.2024.
//

import UIKit

protocol SearchFilmRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

final class SearchFilmRouter: SearchFilmRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let searchVC = DetailSearchFilmAssemble.assemble()
        searchVC.detailSearchFilmView.configure(with: model)
        viewController.navigationController?.pushViewController(searchVC, animated: true)
    }
}
