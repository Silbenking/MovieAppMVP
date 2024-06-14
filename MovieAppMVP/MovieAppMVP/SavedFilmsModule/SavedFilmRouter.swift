//
//  SavedFilmRouter.swift
//  MovieAppMVP
//
//

import UIKit

protocol SaveRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

final class SaveRouter: SaveRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let saveVC = DetailMovieAssemble.assemble(film: model)
        print(model)
        saveVC.detailMovieView.configure(with: model)
        viewController.navigationController?.pushViewController(saveVC, animated: true)
    }

}
