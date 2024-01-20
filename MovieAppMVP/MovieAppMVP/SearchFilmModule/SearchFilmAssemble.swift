//
//  SearchFilmAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.01.2024.
//

import UIKit

struct SearchFilmAssemble {
    static func assemble() -> UIViewController {
        let presenter = SearchFilmPresenter()
        let viewController = SearchFilmTableVC(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
