//
//  SavedFilmsPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
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
        storageService.clearAllFilms()
        arrayFilms = []
        self.view.reloadTableView()
    }

    func loadData() {
        arrayFilms = storageService.read()
        self.view.reloadTableView()
    }

    func deleteFilm(film: Film) {
        storageService.delete(film: film)
    }
}
