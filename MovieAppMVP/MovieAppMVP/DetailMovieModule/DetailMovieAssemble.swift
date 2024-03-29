//
//  DetailMovieAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 30.12.2023.
//

import UIKit

struct DetailMovieAssemble {

    static func assemble(film: Film) -> DetailMovieViewController {
        let storage = Storage()
        let presenter = DetailMoviePresenter(storageService: storage, movieDetailPresenterModel: film)
        let viewController = DetailMovieViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
