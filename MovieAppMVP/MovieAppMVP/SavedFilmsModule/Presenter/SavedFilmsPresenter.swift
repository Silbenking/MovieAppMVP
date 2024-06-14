//
//  SavedFilmsPresenter.swift
//  MovieAppMVP
//
//

import RealmSwift

protocol SavedFilmsPresenterProtocol: AnyObject {
    func loadData()
    var arrayFilms: [Film] { get set }
    func clearHandle()
    func deleteFilm(film: Film)
}

final class SavedFilmsPresenter {

    weak var view: SavedFilmsVCProtocol!
    let storageService: StorageProtocol
    var arrayFilms: [Film] = []

    init(storageService: StorageProtocol) {
        self.storageService = storageService
    }
}

extension SavedFilmsPresenter: SavedFilmsPresenterProtocol {
    func clearHandle() {
        do {
           try storageService.clearAllFilms()
        } catch {
            view.errorDelete()
        }
        arrayFilms = []
        self.view.reloadTableView()
    }

    func loadData() {
        arrayFilms = storageService.read()
        self.view.reloadTableView()
    }

    func deleteFilm(film: Film) {
        do {
           try storageService.delete(film: film)
        } catch {
            view.errorDelete()
        }
    }
}
