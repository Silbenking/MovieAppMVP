//
//  TopChartPresenter.swift
//  MovieAppMVP
//
//

import Foundation

protocol TopChartPresenterProtocol: AnyObject {
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
                let film2 = movieResult.docs?.compactMap({ Film(filmData: $0)
                })

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
