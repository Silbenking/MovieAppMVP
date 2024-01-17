//
//  TopChartPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import Foundation

protocol TopChartPresenterProtocol: AnyObject { // описываются те действия, на которые должен реагировать презентер(должен знать как обрабатывать события при том или ином дейтсвии - вообщем бизнес-логика)
    func loadData()
    var dataSource: [TopChartsModel] { get }
}

final class TopChartPresenter {

    weak var view: TopChartVCProtocol!
    let networMoviewkService = NetworkMoviekService()
    var dataSource: [TopChartsModel] = []

}

extension TopChartPresenter: TopChartPresenterProtocol {
    func loadData() {
        networMoviewkService.fetchData { [weak self] result in
            switch result {
            case .success(let movieResult):
                for _ in movieResult.docs! {
                    self?.dataSource.append(movieResult)
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
