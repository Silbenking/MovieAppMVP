//
//  SearchFilmPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 18.01.2024.
//

import Foundation

protocol SearchFilmPresenterProtocol: AnyObject {
    func loadSearchFilm(filmName: String)
    var dataSource: [Film] {get set}
    func inputText(text: String)
    func reloadData()
}

final class SearchFilmPresenter {

    weak var view: SearchFilmTableVCProtocol!
    var dataSource: [Film] = [] {
        didSet {
            view.reloadData()
        }
    }
    private let networkService: NetworMoviewkServiceProtocol
    private var timer: Timer?

    init(networkService: NetworMoviewkServiceProtocol) {
        self.networkService = networkService
    }
}

extension SearchFilmPresenter: SearchFilmPresenterProtocol {
    func reloadData() {
        view.reloadData()
    }

    func inputText(text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.loadSearchFilm(filmName: text)
        })
    }

    func loadSearchFilm(filmName: String) {
        timer = nil
        networkService.fetchFilm(urlString: filmName) { [weak self] result in
            switch result {
            case .success(let filmResult):
//                if let sortedResult = filmResult.sorted(by: { firstItem, secondItem in
//                    return firstItem.name?.compare(secondItem.name ?? "nil") == ComparisonResult.orderedAscending
//                }) {
                let filmArray = filmResult.docs?.map({ Film(filmData: $0)})
                if let filmArray = filmArray {
                    self?.dataSource = filmArray
                }
                   self?.view.reloadData()
            case let .failure(error):
                switch error {
                case .network:
                    self?.view.errorNetwork()
                case .decode:
                    self?.view.errorDecode()
                }
            }
        }
    }
}
