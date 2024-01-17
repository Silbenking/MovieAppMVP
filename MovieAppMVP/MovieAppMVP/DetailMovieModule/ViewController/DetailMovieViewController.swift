//
//  DetailMovieViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import UIKit

protocol DetailMovieVCProtocol: AnyObject {

    func saveFilm()
    func savedFilm()

}

final class DetailMovieViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: DetailMoviePresenterProtocol!
    let detailMovieView = DetailMovieView()

    init(presenter: DetailMoviePresenterProtocol) { // не понятно как инициализировать
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = detailMovieView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.checkButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
    }

    func setupTarget() {

        detailMovieView.saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)

    }
}

extension DetailMovieViewController: DetailMovieVCProtocol {
    func saveFilm() {
        detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        detailMovieView.saveButton.setTitle("Сохранено", for: .normal)
    }

    func savedFilm() {
        detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        detailMovieView.saveButton.setTitle("Сохранить", for: .normal)
    }

    @objc func saveAction() {
        presenter.handleSaveMovieButton()
    }

}
