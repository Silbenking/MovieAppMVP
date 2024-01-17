//
//  SaveDetailVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 14.01.2024.
//

import UIKit
import Kingfisher

protocol SaveDetailVCProtocol: AnyObject {

}

final class SaveDetailVC: UIViewController {

    private var presenter: SaveDetailPresenterProtocol!
    let detailMovieView = SaveDetailView()
    var movieDetailModel: Film?

    init(presenter: SaveDetailPresenterProtocol) { // не понятно как инициализировать
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = detailMovieView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

extension SaveDetailVC: SaveDetailVCProtocol {
    
}
