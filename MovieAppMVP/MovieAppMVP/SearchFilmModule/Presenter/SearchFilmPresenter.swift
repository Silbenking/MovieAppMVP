//
//  SearchFilmPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 18.01.2024.
//

import Foundation

protocol SearchFilmPresenterProtocol: AnyObject {
    func loadSearchFilm(filmName: String)
    var dataSource: [Doc] {get set}
    func inputText(text: String)
}

final class SearchFilmPresenter {

    weak var view: SearchFilmTableVCProtocol!
    let networkService = NetworkMoviekService()
    var dataSource: [Doc] = []
    var timer: Timer?
}

extension SearchFilmPresenter: SearchFilmPresenterProtocol {
    func inputText(text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.loadSearchFilm(filmName: text)
        })
    }

    func loadSearchFilm(filmName: String) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=\(filmName)"
        networkService.fetchFilm(urlString: url) { [weak self] result in
            switch result {
            case .success(let filmResult):
               if let sortedResult = filmResult.docs?.sorted { firstItem, secondItem in
                    return firstItem.name?.compare(secondItem.name ?? "nil") == ComparisonResult.orderedAscending
               } {
                   self?.dataSource = sortedResult
                   self?.view.reloadData()
               } else {
                   print("sortedResult является nil")
               }
            case let .failure(error):
                switch error {
                case .network:
                    print("проблема с ссылкой")
                case .decode:
                    print("проблема с декодированием")
                }
            }
        }
    }
}
