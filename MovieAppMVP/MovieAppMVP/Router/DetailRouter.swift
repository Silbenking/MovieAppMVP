//
//  DetailRouter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

protocol DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: DetailMovieView.ViewModel)
}

extension Router: DetailRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: DetailMovieView.ViewModel) {
        let detailVC = DetailMovieAssemble.assemble()
        detailVC.detailMovieView.configure(with: model)
        detailVC.movieDetailModel = model
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
