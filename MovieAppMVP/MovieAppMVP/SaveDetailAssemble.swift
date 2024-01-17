//
//  SaveDetailAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 14.01.2024.
//

import Foundation

struct SaveDetailAssemble {

    static func assemble() -> SaveDetailVC {
        let storage = Storage()
        let presenter = SaveDetailPresenter(storageService: storage)
        let viewController = SaveDetailVC(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
