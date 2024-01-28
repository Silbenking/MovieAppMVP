//
//  SavedFilmRouter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 14.01.2024.
//

import UIKit

protocol SaveRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film)
}

final class SaveRouter: SaveRouterProtocol {
    func showDetailMovie(from viewController: UIViewController, model: Film) {
        let saveVC = DetailMovieAssemble.assemble()
        saveVC.detailMovieView.configure(with: model)
        viewController.navigationController?.pushViewController(saveVC, animated: true)
    }

}
