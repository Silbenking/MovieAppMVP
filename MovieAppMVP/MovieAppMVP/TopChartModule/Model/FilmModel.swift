//
//  FilmModel.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 27.01.2024.
//

import Foundation

struct Film: Equatable {
    var id: Int = 0
    var nameMovie: String = ""
    var movieImage: String = ""
    var countryMovie: String = ""
    var yearOfRealiseMovie: String = ""
    var ratingMovie: String = ""
    var descriptionMovie: String = ""
    
    init?(filmData: TopChartsModel) {
        id = filmData.docs?.first?.id ?? 0
        nameMovie = filmData.docs?.first?.name ?? ""
        movieImage = filmData.docs?.first?.poster?.url ?? ""
        countryMovie = filmData.docs?.first?.countries?.first?.name ?? ""
        yearOfRealiseMovie = "\(filmData.docs?.first?.year ?? 0)"
        ratingMovie = "\(filmData.docs?.first?.rating?.imdb ?? 0)"
        descriptionMovie = filmData.docs?.first?.description ?? ""
    }
    
    init (filmRealm: SavedModel) {
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
