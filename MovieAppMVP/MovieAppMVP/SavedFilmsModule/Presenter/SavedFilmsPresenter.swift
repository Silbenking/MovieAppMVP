//
//  SavedFilmsPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import Foundation

protocol SavedFilmsPresenterProtocol: AnyObject {
    
    func addSavedFilms(film: TopChartsModel) 
    var dataSavedSource: [TopChartsModel] { get }
    
}

final class SavedFilmsPresenter {
    
    weak var view: SavedFilmsVCProtocol!
    var dataSavedSource: [TopChartsModel] = []
    
}

extension SavedFilmsPresenter: SavedFilmsPresenterProtocol {
    
    func addSavedFilms(film: TopChartsModel) {
        dataSavedSource.append(film)
    }
    
    
    
    
    
}
