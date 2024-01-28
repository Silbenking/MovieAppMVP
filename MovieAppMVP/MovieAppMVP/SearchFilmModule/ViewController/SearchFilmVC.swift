//
//  SearchFilmTableVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 18.01.2024.
//

import UIKit

protocol SearchFilmTableVCProtocol: AnyObject {
    func reloadData()
    func errorDecode()
    func errorNetwork()
}

final class SearchFilmTableVC: UIViewController {

    private var presenter: SearchFilmPresenterProtocol!
    private let searchView = SearchFilmView()
    private let router = SearchFilmRouter()
    
    init(presenter: SearchFilmPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    func reloadData() {
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }

    private func setupTableView() {
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
    }

    private func setupSearchBar() {
        searchView.searchBar.delegate = self
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchFilmTableVC: SearchFilmTableVCProtocol {
    func errorDecode() {
        errorAlert(nameError: "Ошибка декодирования")
    }

    func errorNetwork() {
        errorAlert(nameError: "Ошибка сети")
    }
}

extension SearchFilmTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         presenter.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else {fatalError()}
        let detail = presenter.dataSource[indexPath.row]
        cell.configure(with: detail)
        return cell
    }
}

extension SearchFilmTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = presenter.dataSource[indexPath.row]
        router.showDetailMovie(from: self, model: detail)
    }
}

extension SearchFilmTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let textWithoutSpaces = searchText.replacingOccurrences(of: " ", with: "")
        if textWithoutSpaces.isEmpty {
            presenter.dataSource = []
        } else {
            let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            presenter.inputText(text: text ?? "nil")
        }
    }
}
