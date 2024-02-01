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
    func delete(film: Film) throws
    func save(film: Film) throws
    func read() -> [Film]
    func checkFilm(film: Film) -> Bool
    func clearAllFilms() throws
}

final class Storage: StorageProtocol {

    let realm = try! Realm()

    func clearAllFilms() throws {
        let object = realm.objects(SavedModel.self)
            try realm.write({ 
                realm.delete(object)
            })
    }

    func checkFilm(film: Film) -> Bool {

        let filmId = film.id
        print(filmId)
        return !realm.objects(SavedModel.self).filter("id == %@", filmId).isEmpty
    }

    func delete(film: Film) throws {
        let filmId = film.id
        let film = realm.objects(SavedModel.self).filter("id == %@", filmId).first
        if let film = film {
                try realm.write({
                    realm.delete(film)
                })
        }
    }
    
    func save(film: Film) throws {
        let object = SavedModel(value: [film.id, film.nameMovie, film.countryMovie, film.movieImage, film.yearOfRealiseMovie, film.ratingMovie, film.descriptionMovie])
            try realm.write({
                realm.add(object)
            })
    }

    func read() -> [Film] {
        let object = realm.objects(SavedModel.self)
        let films = Array(object.map({Film(filmRealm: $0)}))
        return films
        }
    }
