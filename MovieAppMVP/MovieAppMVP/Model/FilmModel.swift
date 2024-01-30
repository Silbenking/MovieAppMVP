//
//  FilmModel.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 27.01.2024.
//

import Foundation

struct Film: Equatable {
    var id: Int = 0
    var nameMovie: String = "Ощхф"
    var movieImage: String = "Test"
    var countryMovie: String = ""
    var yearOfRealiseMovie: String = ""
    var ratingMovie: String = ""
    var descriptionMovie: String = ""

    init(filmData: Doc) {
        id = filmData.id
        nameMovie = filmData.name ?? ""
        movieImage = filmData.poster?.url ?? ""
        countryMovie = filmData.countries?.first?.name ?? ""
        yearOfRealiseMovie = "\(filmData.year ?? 0)"
        ratingMovie = "\(filmData.rating?.imdb ?? 0)"
        descriptionMovie = filmData.description ?? ""
    }

    init(filmRealm: SavedModel) {
        id = filmRealm.id
        nameMovie = filmRealm.nameMovie
        movieImage = filmRealm.imageMovie
        countryMovie = filmRealm.countryMovie
        yearOfRealiseMovie = "\(filmRealm.yearOfRealiseMovie)"
        ratingMovie = "\(filmRealm.ratingMovie)"
        descriptionMovie = filmRealm.descriptionMovie
    }

    init() {}
}
