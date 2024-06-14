//
//  DetailRouter.swift
//  MovieAppMVP
//
//

import UIKit

protocol DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

class DetailRouter: DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let detailVC = DetailMovieAssemble.assemble(film: model)
        detailVC.detailMovieView.configure(with: model)
        print(model)
        if let presenter = detailVC.presenter {
            presenter.movieDetailPresenterModel = model
        }
        
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
