//
//  DetailMovieViewController.swift
//  MovieAppMVP
//
//

import UIKit

protocol DetailMovieVCProtocol: AnyObject {

    func saveFilm()
    func savedFilm()
    func errorSaved()
    func errorDelete()
}

final class DetailMovieViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: DetailMoviePresenterProtocol?
    let detailMovieView = DetailMovieView()

    init(presenter: DetailMoviePresenterProtocol) { 
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
        presenter?.checkButton()
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
    func errorDelete() {
        errorAlert(nameError: "Ошибка удаления")
    }

    func errorSaved() {
        errorAlert(nameError: "Ошибка сохранения")
    }

    func saveFilm() {
        detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        detailMovieView.saveButton.setTitle("Сохранено", for: .normal)
    }

    func savedFilm() {
        detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        detailMovieView.saveButton.setTitle("Сохранить", for: .normal)
    }

    @objc func saveAction() {
        presenter?.handleSaveMovieButton()
    }

}
