//
//  SerachFilmRouter.swift
//  MovieAppMVP
//
//

import UIKit

protocol SearchFilmRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

final class SearchFilmRouter: SearchFilmRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let searchVC = DetailMovieAssemble.assemble(film: model)
        print(model)
        searchVC.detailMovieView.configure(with: model)
        viewController.navigationController?.pushViewController(searchVC, animated: true)
    }
}
