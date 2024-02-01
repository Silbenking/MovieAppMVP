//
//  DetailRouter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

protocol DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

class DetailRouter: DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let detailVC = DetailMovieAssemble.assemble(film: model)
        detailVC.detailMovieView.configure(with: model)
//        detailVC.movieDetailModel = model
        print(model)
        if let presenter = detailVC.presenter {
            presenter.movieDetailPresenterModel = model
        } // зачем эта проверка, если можно сделать как ниже

//        detailVC.presenter.movieDetailPresenterModel = model
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
