//
//  Storage.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.01.2024.
//

import Foundation
import RealmSwift
import Realm

final class SavedModel: Object {
    @Persisted var id = 0
    @Persisted var nameMovie = ""
    @Persisted var countryMovie = ""
    @Persisted var imageMovie = ""
    @Persisted var yearOfRealiseMovie = ""
    @Persisted var ratingMovie = ""
    @Persisted var descriptionMovie = ""

}

protocol StorageProtocol {
    func delete(film: Film)
    func save(film: Film)
    func read() -> [Film]
    func checkFilm(film: Film) -> Bool
    func clearAllFilms()
}

final class Storage: StorageProtocol {

    var presenter: DetailMoviePresenterProtocol?

    let realm = try! Realm()

    func clearAllFilms() {
        let object = realm.objects(SavedModel.self)
        do {
            try realm.write({ // Если ставим опциональный try, то пишет что catch не нужен
                realm.delete(object)
            })
        } catch {
            presenter?.errorDelete()
        }
    }

    func checkFilm(film: Film) -> Bool {

        let filmId = film.id
        let film = realm.objects(SavedModel.self).filter("id == %@", filmId).first
        if let _ = film {
            print("фильм уже есть")
            return true
        } else {
            print("фильма нет")
            return false

        }
    }

    func delete(film: Film) {
        let filmId = film.id
        let film = realm.objects(SavedModel.self).filter("id == %@", filmId).first
        if let film = film {
            do {
                try realm.write({
                    realm.delete(film)
                })
            } catch {
                presenter?.errorDelete()
            }
        }
    }

    func save(film: Film) {
        let object = SavedModel(value: [film.id, film.nameMovie, film.countryMovie, film.movieImage, film.yearOfRealiseMovie, film.ratingMovie, film.descriptionMovie])
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            presenter?.errorSaved()
        }
    }

    func read() -> [Film] {
        let object = realm.objects(SavedModel.self)
        let films = Array(object.map {Film(filmRealm: $0)})
        return films
        }
    }
