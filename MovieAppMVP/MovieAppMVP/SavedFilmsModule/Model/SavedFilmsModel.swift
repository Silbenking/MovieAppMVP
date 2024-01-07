//
//  SavedFilmsModel.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import RealmSwift

class SavedModel: Object {
    @Persisted var nameMovie = ""
    @Persisted var countryMovie = ""
    @Persisted var imgeMovie = ""
}
