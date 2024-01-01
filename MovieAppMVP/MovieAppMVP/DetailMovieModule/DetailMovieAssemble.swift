//
//  DetailMovieAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 30.12.2023.
//

import UIKit

struct DetailMovieAssemble {
    
    static func assemble() -> DetailMovieViewController {
        
        let presenter = DetailMoviePresenter()
        let viewController = DetailMovieViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
