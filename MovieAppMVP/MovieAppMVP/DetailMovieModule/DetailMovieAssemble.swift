//
//  DetailMovieAssemble.swift
//  MovieAppMVP
//
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
