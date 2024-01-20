//
//  SearchFilmPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 18.01.2024.
//

import Foundation

protocol SearchFilmPresenterProtocol: AnyObject {
    func loadSearchFilm(filmName: String)
    var dataSource: [TopChartsModel] {get set}
    func inputText(text: String)
}

final class SearchFilmPresenter {

    weak var view: SearchFilmTableVCProtocol!
    let networkService = NetworkMoviekService()
    var dataSource: [TopChartsModel] = []
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
                for _ in filmResult.docs! {
                    self?.dataSource.append(filmResult)
                }
                let sortedResult =  self?.dataSource.sorted { firstItem, secondItem in
                    return firstItem.docs?.first?.name?.compare(secondItem.docs?.first?.name ?? "nil") == ComparisonResult.orderedAscending
                }
                self?.dataSource = sortedResult!
                self?.view.reloadData()
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
