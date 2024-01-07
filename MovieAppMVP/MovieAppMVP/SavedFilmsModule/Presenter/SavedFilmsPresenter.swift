//
//  SavedFilmsPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import RealmSwift

protocol SavedFilmsPresenterProtocol: AnyObject {
    func notificatinAddObserverReloadTable()
}

final class SavedFilmsPresenter {
    
    weak var view: SavedFilmsVCProtocol!
    var saveArray: Results<SavedModel>!
    let notificationCenter = NotificationCenter.default
}

extension SavedFilmsPresenter: SavedFilmsPresenterProtocol {
    func notificatinAddObserverReloadTable() {
        notificationCenter.addObserver(forName: NSNotification.Name("reloadTable"), object: nil, queue: nil) { [weak self] _ in //всегда ли нужно когда стоит замыкание стаивть weakself?
            self?.view.reloadTableView()
        }
    }
    
    func reloadTableViewFilm() {
    
    }

}
