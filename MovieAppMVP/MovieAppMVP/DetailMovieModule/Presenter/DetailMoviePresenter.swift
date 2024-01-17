//
//  DetailMoviePresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import Foundation

protocol DetailMoviePresenterProtocol: AnyObject {
    
    func handleSaveMovieButton()
    func saveData(film: Film)
    func deleteFilm(film: Film)
    var movieDetailPresenterModel: Film? { get set }
    func checkFilm()
    func checkButton()
}

final class DetailMoviePresenter {

    weak var view: DetailMovieVCProtocol!
    var movieDetailPresenterModel: Film?
    let storageService: StorageProtocol

    init(storageService: StorageProtocol) {
        self.storageService = storageService
    }
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    func checkButton() {
        let check = storageService.checkFilm(film: movieDetailPresenterModel!)
        if check == true {
            view.saveFilm()
        } else {
            view.savedFilm()
        }
    }

    func checkFilm() {
        let check = storageService.checkFilm(film: movieDetailPresenterModel!)
        if check == true {
            deleteFilm(film: movieDetailPresenterModel!)
            view.savedFilm()
        } else {
            saveData(film: movieDetailPresenterModel!)
            view.saveFilm()
        }
    }

    func deleteFilm(film: Film) {
        storageService.delete(film: film)
    }
    func saveData(film: Film) {
        storageService.save(film: film) // тут надо добавить в константу?
    }

    func handleSaveMovieButton() {
       checkFilm()
    }

}
