//
//  SavedFilmsVC.swift
//  MovieAppMVP
//
//
import UIKit

protocol SavedFilmsVCProtocol: AnyObject {
    func reloadTableView()
    func errorDelete()
}

final class SavedFilmsVC: UIViewController {

    let savedView = SavedFilmView()
    private var presenter: SavedFilmsPresenterProtocol!
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
        presenter?.loadData()
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
       presenter?.clearHandle()
    }
}

// MARK: - extension View

extension SavedFilmsVC: SavedFilmsVCProtocol {
    func reloadTableView() {
        savedView.tableView.reloadData()
    }
    func errorDelete() {
        errorAlert(nameError: "Ошибка удаления")
    }
}
// MARK: - setup TableViewDataSource

extension SavedFilmsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.arrayFilms.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else {fatalError()}
        let array = presenter.arrayFilms[indexPath.row]
        cell.configure(with: array)
        return cell
    }
}
// MARK: - setup TableView Delegate

extension SavedFilmsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = presenter.arrayFilms[indexPath.row]
        router.showDetailMovie(from: self, model: detail)

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [self] _, _, _ in
            let editingRow = self.presenter?.arrayFilms[indexPath.row]
            if let index = self.presenter?.arrayFilms.firstIndex(of: editingRow!) {
                presenter?.arrayFilms.remove(at: index)
                presenter?.deleteFilm(film: editingRow!) 
            }
            presenter?.loadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
