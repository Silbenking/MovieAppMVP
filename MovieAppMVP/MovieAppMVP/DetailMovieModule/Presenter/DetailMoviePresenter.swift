//
//  DetailMoviePresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import Foundation
import RealmSwift

protocol DetailMoviePresenterProtocol: AnyObject {
    
    func handleSaveMovieButton()
    func notificationReloadTable()
}

class DetailMoviePresenter {
    
    weak var view: DetailMovieVCProtocol!
    let notificationCenter = NotificationCenter.default
    
//    let realm = try! Realm()
//    var movieDetailModel: DetailMovieView.ViewModel?
//    let value = SavedModel(value: [movieDetailModel?.nameMovie, movieDetailModel?.countryMovie, movieDetailModel?.movieImage])
//
//    try! realm.write({
//        realm.add(value)
//    })
    
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    func notificationReloadTable() {
        notificationCenter.post(name: NSNotification.Name("reloadTable"), object: nil)
    }
    
    func handleSaveMovieButton() {
        view.saveButton()
    }
    
}
