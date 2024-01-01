//
//  DetailMoviePresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import Foundation

protocol DetailMoviePresenterProtocol: AnyObject {
    
    func handleSaveMovieButton()
}

class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    weak var view: DetailMovieVCProtocol!
    
    func handleSaveMovieButton() {
        view.saveButton()
    }
}
