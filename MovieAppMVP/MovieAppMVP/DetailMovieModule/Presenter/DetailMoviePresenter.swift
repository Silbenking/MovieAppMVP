//
//  DetailMoviePresenter.swift
//  MovieAppMVP
//
//

import Foundation

protocol DetailMoviePresenterProtocol: AnyObject {
    
    func handleSaveMovieButton()
    func saveData(film: Film)
    func deleteFilm(film: Film)
    var movieDetailPresenterModel: Film {get set}
    func checkFilm()
    func checkButton()
}

final class DetailMoviePresenter {

    weak var view: DetailMovieVCProtocol!
    var movieDetailPresenterModel: Film
    let storageService: StorageProtocol

    init(storageService: StorageProtocol, movieDetailPresenterModel: Film) {
        self.storageService = storageService
        self.movieDetailPresenterModel = movieDetailPresenterModel
    }
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {

    func checkButton() {
        let isFavorite = storageService.checkFilm(film: movieDetailPresenterModel)
        if isFavorite == true {
            view.saveFilm()
        } else {
            view.savedFilm()
        }
    }

    func checkFilm() {
        let check = storageService.checkFilm(film: movieDetailPresenterModel)
        if check == true {
            deleteFilm(film: movieDetailPresenterModel)
            view.savedFilm()
        } else {
            saveData(film: movieDetailPresenterModel)
            print("Save - \(movieDetailPresenterModel)")
            view.saveFilm()
        }
    }

    func deleteFilm(film: Film) {
        do {
            try storageService.delete(film: film)
        } catch {
            view.errorDelete()
        }
    }
    func saveData(film: Film) {
        do {
           try storageService.save(film: film)
        } catch {
            view.errorSaved()
        }
    }

    func handleSaveMovieButton() {
       checkFilm()
    }
}
