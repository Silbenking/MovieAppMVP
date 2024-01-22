//
//  DetailSearchFilmVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 22.01.2024.
//

import UIKit

final class DetailSearchFilmVC: UIViewController {

    let detailSearchFilmView = DetailSearchFilmView()

    override func loadView() {
        self.view = detailSearchFilmView
    }

}
