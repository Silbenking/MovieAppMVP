//
//  SavedFilmsAssemble.swift
//  MovieAppMVP
//
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
