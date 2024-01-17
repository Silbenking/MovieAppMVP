//
//  SavedFilmsAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

struct SavedFilmsAssemble {

    static func assemble() -> UIViewController {
        let storage = Storage()
        let presenter = SavedFilmsPresenter(storageService: storage)
        let viewController = SavedFilmsVC(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
