//
//  SearchFilmTableVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 18.01.2024.
//

import UIKit

protocol SearchFilmTableVCProtocol: AnyObject {
    func reloadData()
}

final class SearchFilmTableVC: UIViewController {

    private var presenter: SearchFilmPresenterProtocol!
    private let searchView = SearchFilmView()
    
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

    private func setupTableView() {
        searchView.tableView.dataSource = self
    }

    private func setupSearchBar() {
        searchView.searchBar.delegate = self
//        navigationItem.searchController = searchView.searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchFilmTableVC: SearchFilmTableVCProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.searchView.tableView.reloadData()
        }
    }

}

extension SearchFilmTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchFilmCell.identifier, for: indexPath) as? SearchFilmCell else {fatalError()}
        let detail = presenter.dataSource.first?.docs?[indexPath.row]
        let model = Film(id: detail?.id ?? 0, nameMovie: detail?.name ?? "name",
                         movieImage: detail?.poster?.url ?? "test",
                         countryMovie: detail?.countries?.first?.name ?? "country",
                         yearOfRealiseMovie: "\(detail?.year ?? 1)",
                         ratingMovie: "\(detail?.rating?.imdb ?? 8.5)",
                         descriptionMovie: detail?.description ?? "description")
        cell.configure(with: model)
        return cell
    }
}

extension SearchFilmTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if text != "" {
            presenter.inputText(text: text ?? "nil")
            searchView.tableView.reloadData()
        } else {
            presenter.dataSource = []
        }
    }
}