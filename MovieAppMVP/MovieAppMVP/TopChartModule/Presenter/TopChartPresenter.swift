//
//  TopChartPresenter.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import Foundation

protocol TopChartPresenterProtocol: AnyObject { // описываются те действия, на которые должен реагировать презентер(должен знать как обрабатывать события при том или ином дейтсвии - вообщем бизнес-логика)
}

final class TopChartPresenter {
    
    weak var view: TopChartVCProtocol!

}

extension TopChartPresenter: TopChartPresenterProtocol {
    
}
