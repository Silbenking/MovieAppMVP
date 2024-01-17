//
//  Storage.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.01.2024.
//

import Foundation
import RealmSwift
import Realm

class SavedModel: Object {
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
    func save(film: Film) -> SavedModel
    func read() -> [Film]
    func checkFilm(film: Film) -> Bool
    func clearAllFilms()
//    var swiftModel: [SavedModel] {get}
}

final class Storage: StorageProtocol {
    func clearAllFilms() {
        let object = realm.objects(SavedModel.self)
        try! realm.write({
            realm.delete(object)
        })
    }

    func checkFilm(film: Film) -> Bool  {

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

    let realm = try! Realm()

    func delete(film: Film) {
        let filmId = film.id
        let film = realm.objects(SavedModel.self).filter("id == %@", filmId).first
        if let film = film {
            try! realm.write({
                realm.delete(film)
            })
        }
    }

    func save(film: Film) -> SavedModel {
        let object = SavedModel(value: [film.id, film.nameMovie, film.countryMovie, film.movieImage, film.yearOfRealiseMovie, film.ratingMovie, film.descriptionMovie])
        try! realm.write({
                 realm.add(object)
             })
        return object
    }

    func read() -> [Film] {
        let object = realm.objects(SavedModel.self)
        let films = Array(object.map {Film(id: $0.id, nameMovie: $0.nameMovie, movieImage: $0.imageMovie, countryMovie: $0.countryMovie, yearOfRealiseMovie: $0.yearOfRealiseMovie, ratingMovie: $0.ratingMovie, descriptionMovie: $0.descriptionMovie)})
        return films
        }
    }

struct Film: Equatable {
    let id: Int
    let nameMovie: String
    let movieImage: String
    let countryMovie: String
    let yearOfRealiseMovie: String
    let ratingMovie: String
    let descriptionMovie: String
}
