//
//  SearchFilmAssemble.swift
//  MovieAppMVP
//
//

import UIKit

struct SearchFilmAssemble {
    static func assemble() -> UIViewController {
        let networkService = NetworkMoviekService()
        let presenter = SearchFilmPresenter(networkService: networkService)
        let viewController = SearchFilmTableVC(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
