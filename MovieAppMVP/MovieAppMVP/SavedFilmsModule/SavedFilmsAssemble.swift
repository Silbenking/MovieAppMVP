//
//  SavedFilmsAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

struct SavedFilmsAssemble {
    
    static func assemble() -> UIViewController {
        
        let presenter = SavedFilmsPresenter()
        let viewController = SavedFilmsVC(presenter: presenter)
        presenter.view = viewController
        return viewController
        
    }
}
