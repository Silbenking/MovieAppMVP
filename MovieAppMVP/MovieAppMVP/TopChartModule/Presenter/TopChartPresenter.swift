//
//  TopChartPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import Foundation

protocol TopChartPresenterProtocol: AnyObject { // описываются те действия, на которые должен реагировать презентер(должен знать как обрабатывать события при том или ином дейтсвии - вообщем бизнес-логика)
    func loadData()
    var dataSource: [Film] { get }
}

final class TopChartPresenter {

    weak var view: TopChartVCProtocol!
    let networMoviewkService: NetworMoviewkServiceProtocol
    var dataSource: [Film] = []
    
    init(networMoviewkService: NetworMoviewkServiceProtocol) {
        self.networMoviewkService = networMoviewkService
    }

}

extension TopChartPresenter: TopChartPresenterProtocol {
    func loadData() {
        networMoviewkService.fetchData { [weak self] result in
            switch result {
            case .success(let movieResult):
//                let film = movieResult.docs.map {Film(filmData: $0)}
                let film2 = movieResult.docs?.compactMap({ Film(filmData: $0)
                })
//                        self?.dataSource.append(movieResult)                    }
//                let filmArray = Film(film)
                if let film2 = film2 {
                    self?.dataSource = film2
                }
                    self?.view.reloadData()
            case let .failure(error):
                switch error {
                case .decode:
                    self?.view.errorDecode()
                case .network:
                    self?.view.errorNetwork()
                }
            }
        }
    }
}
