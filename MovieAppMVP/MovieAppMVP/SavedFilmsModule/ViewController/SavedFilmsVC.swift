//
//  SavedFilmsVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//
import UIKit

protocol SavedFilmsVCProtocol: AnyObject {
    func reloadTableView()
}

final class SavedFilmsVC: UIViewController {

    private var presenter: SavedFilmsPresenterProtocol!
    let savedView = SavedFilmView()
    private let router: SaveRouterProtocol = SaveRouter()

    init(presenter: SavedFilmsPresenterProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = savedView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTarget()
    }
    // MARK: - setup TableView

   private func setupTableView() {
        savedView.tableView.dataSource = self
       savedView.tableView.delegate = self
    }

    private func setupTarget() {
        savedView.clearButton.addTarget(self, action: #selector(clearFilms), for: .touchUpInside)
    }
   @objc func clearFilms() {
       presenter.clearHandle()
    }
}

// MARK: - extension View

extension SavedFilmsVC: SavedFilmsVCProtocol {
    func reloadTableView() {
        savedView.tableView.reloadData()
    }
}
// MARK: - setup TableViewDataSource

extension SavedFilmsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.arrayFilms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedFilmCell.identifier, for: indexPath) as? SavedFilmCell else {fatalError()}
        let array = presenter.arrayFilms[indexPath.row]
        let model = Film(id: array.id, nameMovie: array.nameMovie, movieImage: array.movieImage, countryMovie: array.countryMovie, yearOfRealiseMovie: array.yearOfRealiseMovie, ratingMovie: array.ratingMovie, descriptionMovie: array.descriptionMovie)
        cell.configure(with: model)
        return cell
    }
}
// MARK: - setup TableView Delegate

extension SavedFilmsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = presenter.arrayFilms[indexPath.row]
        let model = Film(id: detail.id, nameMovie: detail.nameMovie,
                         movieImage: detail.movieImage,
                         countryMovie: detail.countryMovie,
                         yearOfRealiseMovie: detail.yearOfRealiseMovie,
                         ratingMovie: detail.ratingMovie,
                         descriptionMovie: detail.descriptionMovie)
        router.showDetailMovie(from: self, model: model)

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [self] _, _, _ in
            let editingRow = self.presenter.arrayFilms[indexPath.row]
            if let index = self.presenter.arrayFilms.firstIndex(of: editingRow) {
                presenter.arrayFilms.remove(at: index)
                presenter.deleteFilm(film: editingRow)
            }
            presenter.loadData() // здесь нужно просто обновить таблицу или нужно с обновлением хранилища
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}