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
        let searchVC = DetailMovieAssemble.assemble()
        searchVC.detailMovieView.configure(with: model)
        viewController.navigationController?.pushViewController(searchVC, animated: true)
    }
}
