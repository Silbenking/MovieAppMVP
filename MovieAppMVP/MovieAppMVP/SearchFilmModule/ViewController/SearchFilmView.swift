//
//  SearchFilmView.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.01.2024.
//

import UIKit

final class SearchFilmView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchFilmCell.self, forCellReuseIdentifier: SearchFilmCell.identifier)
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()

    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск фильмов"
        label.font = .systemFont(ofSize: UIConstant.savedLabelSize, weight: .bold)
        label.textColor = .orange.withAlphaComponent(UIConstant.savedLabelWithAlphaComponent)
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(searchLabel)
        addSubview(tableView)
        addSubview(searchBar)
        backgroundColor = .black

    }

    private func setupLayout() {

        searchLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstant.savedLabelLeading)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(UIConstant.savedLabelTop)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(searchLabel.snp.bottom).inset(UIConstant.searchBarTop)
            make.horizontalEdges.equalToSuperview().inset(10)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchLabel.snp.bottom).inset(UIConstant.tableTop)
            make.bottom.leading.trailing.equalToSuperview().inset(UIConstant.tableHorizontal)
        }
    }
}

private extension SearchFilmView {
    private enum UIConstant {
        static let savedLabelSize: CGFloat = 30
        static let savedLabelWithAlphaComponent: CGFloat = 0.8
        static let savedLabelLeading: CGFloat = 20
        static let savedLabelTop: CGFloat = 10
        static let tableTop: CGFloat = -70
        static let tableHorizontal: CGFloat = 10
        static let searchBarTop: CGFloat = -20

    }
}
