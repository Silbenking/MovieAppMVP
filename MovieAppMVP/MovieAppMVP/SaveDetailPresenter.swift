//
//  SaveDetailPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 14.01.2024.
//

import Foundation

protocol SaveDetailPresenterProtocol: AnyObject {

}

final class SaveDetailPresenter {

    weak var view: SaveDetailVCProtocol!
    var movieDetaSaveilModel: Film?
    let storageService: StorageProtocol

    init(storageService: StorageProtocol) {
        self.storageService = storageService
    }
}

extension SaveDetailPresenter: SaveDetailPresenterProtocol {

}
